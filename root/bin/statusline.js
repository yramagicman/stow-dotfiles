const {
    exec,
    spawn
} = require('child_process');
const EventEmitter = require('events');
const {
    networkInterfaces,
    hostname,
    homedir
} = require('os');
const {
    lstatSync,
    writeFile
} = require('fs');

class MyEmitter extends EventEmitter {}
const ssidEvent = new MyEmitter();
const dropboxEvent = new MyEmitter();
const volumeEvent = new MyEmitter();
const batteryEvent = new MyEmitter();
const updateEvent = new MyEmitter();
const mailEvent = new MyEmitter();
const weatherEvent = new MyEmitter();
const dateEvent = new MyEmitter();

let statusLine = {};

let getSsid = function() {
    let d = new Date();
    let seconds = d.getSeconds();
    if (seconds % 30 === 0) {
        exec('nmcli', {}, function(jsrr, out, err) {
            let id = out.split('\n')[0];
            id = id.split(' ');
            if (id[3] === 'hide_yo_kids_hide_yo_wi-fi') {
                id[3] = 'home';
            }
            ssidEvent.emit('event', id[3]);
            if (err) {
                console.error(`error: ${ err }`);
            }
        });
    }
};

let dropboxStatus = function() {
    exec('dropbox status', {}, function(jsrr, out, err) {
        dropboxEvent.emit('event', out.trim());
        if (err) {
            console.error(`error: ${ err }`);
        }
    });
};

let mail = function() {
    let d = new Date();
    let seconds = d.getSeconds();
    if (seconds % 2 === 0) {
        exec('mailmon', {}, function(jsrr, out, err) {
            mailEvent.emit('event', out.trim());
            if (err) {
                console.error(`error: ${ err }`);
            }
        });
    }
};

let weather = function() {
    let d = new Date();
    let hour = d.getHours();
    let minute = d.getMinutes();
    if (hour % 3 === 0 && minute === 5) {
        exec('weather.py', {}, function(jsrr, out, err) {
            weatherEvent.emit('event', out.trim());
            if (err) {
                console.error(`error: ${ err }`);
            }
        });
    }
    if (!statusLine.weather) {
        exec('weather.py', {}, function(jsrr, out, err) {
            weatherEvent.emit('event', out.trim());
            if (err) {
                console.error(`error: ${ err }`);
            }
        });
    }
};

let network = function() {
    let net = networkInterfaces();
    if (hostname() === 'k-nine') {
        try {
            return net.wlp2s0[0].address;
        } catch (e) {
            return net.lo[0].address;
        }
    } else {

        try {
            return net.enp0s31f6[0].address;
        } catch (e) {
            return net.lo[0].address;
        }
    }
};

let volume = function() {
    let stat;
    stat = exec('amixer -c 0  -- get Master', {}, function(jsrr, out, err) {
        let vol = out.split('\n');
        vol = vol[4].split(' ');
        volumeEvent.emit('event', vol[5] + vol[7]);
        if (err) {
            console.error(`error: ${ err }`);
        }
    });
};

let battery = function() {
    let readline = require('readline');
    let fs = require('fs');
    let batLevel = readline.createInterface({
        input: fs.createReadStream('/sys/class/power_supply/BAT1/capacity')
    });

    batLevel.on('line', function(line) {
        batteryEvent.emit('level', line);
    });

    let batStat = readline.createInterface({
        input: fs.createReadStream('/sys/class/power_supply/BAT1/status')
    });

    batStat.on('line', function(line) {
        batteryEvent.emit('stat', line);
    });
};

let updateRefresh = function() {
    let hour = new Date();
    let home = homedir();
    let stat = lstatSync(home + '/.cache/update_log');
    let output = [];

    hour = hour.getHours();
    if ((hour % 3 === 0) && (stat.mtime.getHours() !== hour)) {
        let refresh = spawn('sudo', ['zypper', 'refresh']);

        refresh.stdout.on('data', function(data) {
            output.push(data);
            writeFile(homedir() + '/.cache/update_log', output.join(''), function(err) {
                if (err) {
                    console.error(`error: ${ err }`);
                }
            });
        });

        refresh.stderr.on('data', function(data) {
            console.error(`error: ${ data }`);
        });
    }
};

let updateCount = function() {
    let minute = new Date();
    let home = homedir();
    let stat = lstatSync(home + '/.cache/node_updates');
    let output = [];

    minute = minute.getMinutes();
    if ((minute % 5 === 0) && (stat.mtime.getMinutes() !== minute)) {
        let refresh = spawn('zypper', ['lu']);

        refresh.stdout.on('data', function(data) {

            let dontPrint = ['Loading repository data...\n',
                'Reading installed packages...\n',
                'No updates found.\n'
            ];
            if (data.toString() !== '' && !dontPrint.includes(data.toString())) {
                let d = data.toString().split('\n');
                d.forEach(function(item) {
                    output.push(item);
                });
            }
            writeFile(home + '/.cache/node_updates', output.join('\n'), function(err) {
                if (err) {
                    console.error(`error: ${ err }`);
                }
            });


            if (output.length > 10) {
                updateEvent.emit('event', output.length);
            }
        });

        refresh.stderr.on('data', function(data) {
            console.error(`error: ${ data }`);
        });

        // refresh.on('close', function(data) {
        //     console.log(data);
        // });
    }
};

let date = function() {
    if (hostname() === 'k-nine') {
        exec('date +"%d/%m/%Y %I:%M:%S"', {}, function(jsrr, out, err) {
            dateEvent.emit('event', out.trim());
            if (err) {
                console.error(`error: ${ err }`);
            }
        });
    } else {

        exec('date +"%a %d %b %Y %I:%M:%S"', {}, function(jsrr, out, err) {
            dateEvent.emit('event', out.trim());
            if (err) {
                console.error(`error: ${ err }`);
            }
        });
    }
};

ssidEvent.on('event', function(ssid) {
    statusLine.network = ssid + ' ' + network();
});

dropboxEvent.on('event', function(stat) {
    statusLine.dropbox = stat;
});

mailEvent.on('event', function(mail) {
    statusLine.mail = mail;
});
volumeEvent.on('event', function(vol) {
    statusLine.volume = vol;
});

batteryEvent.on('level', function(level) {
    statusLine.batteryLevel = level;
});

batteryEvent.on('stat', function(stat) {
    statusLine.batteryStat = stat;
});

updateEvent.on('event', function(count) {
    statusLine.updateCount = count;
});

weatherEvent.on('event', function(weather) {
    statusLine.weather = weather;
});

dateEvent.on('event', function(date) {
    statusLine.date = date;
});

setInterval(function() {
    updateCount();
    updateRefresh();
    getSsid();
    dropboxStatus();
    mail();
    weather();
    volume();
    if (hostname() === 'k-nine') {
        battery();
    }
    date();
    let line = ' ';
    line += `${statusLine.mail || ''} `;
    line += `${statusLine.updateCount || ''} `;
    line += `W:${statusLine.weather || ''} `;
    if (hostname() === 'k-nine') {
        line += `B:${statusLine.batteryLevel || ''} ${statusLine.batteryStat ||''} `;
    }
    if (statusLine.network) {
        line += `N:${statusLine.network || ''} `;
    }
    line += `D:${statusLine.dropbox || ''} V:${statusLine.volume || ''} ${statusLine.date || ''}`;

    let display = spawn('xsetroot', ['-name', line]);
    display.stdout.on('data', () => {});
    display.stderr.on('data', (data) => {
        console.error(`error: ${ data }`);
    });
}, 1000);