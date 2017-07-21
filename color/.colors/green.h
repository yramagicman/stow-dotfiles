/* Terminal colors (16 first used in escape sequence) */
static const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#000000", /* black   */
  [1] = "#1c0b12", /* red     */
  [2] = "#361b25", /* green   */
  [3] = "#592f3f", /* yellow  */
  [4] = "#854960", /* blue    */
  [5] = "#ba6988", /* magenta */
  [6] = "#d2a2b3", /* cyan    */
  [7] = "#eedfe3", /* white   */

  /* 8 bright colors */
  [8]  = "#479382", /* black   */
  [9]  = "#61bba6", /* red     */
  [10] = "#a670c9", /* green   */
  [11] = "#ce9c67", /* yellow  */
  [12] = "#bf8c51", /* blue    */
  [13] = "#ab71d1", /* magenta */
  [14] = "#d87ca0", /* cyan    */
  [15] = "#849b67", /* white   */

  /* special colors */
  [256] = "#000000", /* background */
  [257] = "#eedfe3", /* foreground */
};

/*
 * Default colors (colorname index)
 * foreground, background, cursor
 */
static unsigned int defaultfg = 257;
static unsigned int defaultbg = 256;
static unsigned int defaultcs = 257;
static unsigned int defaultrcs = 256;

/*
 * Colors used, when the specific fg == defaultfg. So in reverse mode this
 * will reverse too. Another logic would only make the simple feature too
 * complex.
 */
static unsigned int defaultitalic = 7;
static unsigned int defaultunderline = 7;
