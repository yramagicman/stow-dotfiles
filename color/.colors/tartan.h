/* Terminal colors (16 first used in escape sequence) */
const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#2e3436", /* black   */
  [1] = "#cc0000", /* red     */
  [2] = "#4e9a06", /* green   */
  [3] = "#c4a000", /* yellow  */
  [4] = "#3465a4", /* blue    */
  [5] = "#75507b", /* magenta */
  [6] = "#06989a", /* cyan    */
  [7] = "#d3d7cf", /* white   */

  /* 8 bright colors */
  [8]  = "#555753", /* black   */
  [9]  = "#ef2929", /* red     */
  [10] = "#8ae234", /* green   */
  [11] = "#fce94f", /* yellow  */
  [12] = "#729fcf", /* blue    */
  [13] = "#ad7fa8", /* magenta */
  [14] = "#34e2e2", /* cyan    */
  [15] = "#eeeeec", /* white   */

  /* special colors */
  [256] = "#2b2b2b", /* background */
  [257] = "#dedede", /* foreground */
};

/*
 * Default colors (colorname index)
 * foreground, background, cursor
 */
unsigned int defaultfg = 257;
unsigned int defaultbg = 256;
unsigned int defaultcs = 257;
unsigned int defaultrcs = 256;

/*
 * Colors used, when the specific fg == defaultfg. So in reverse mode this
 * will reverse too. Another logic would only make the simple feature too
 * complex.
 */
unsigned int defaultitalic = 7;
unsigned int defaultunderline = 7;
