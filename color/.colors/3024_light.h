/* Terminal colors (16 first used in escape sequence) */
const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#090300", /* black   */
  [1] = "#db2d20", /* red     */
  [2] = "#01a252", /* green   */
  [3] = "#fded02", /* yellow  */
  [4] = "#01a0e4", /* blue    */
  [5] = "#a16a94", /* magenta */
  [6] = "#b5e4f4", /* cyan    */
  [7] = "#a5a2a2", /* white   */

  /* 8 bright colors */
  [8]  = "#5c5855", /* black   */
  [9]  = "#db2d20", /* red     */
  [10] = "#01a252", /* green   */
  [11] = "#fded02", /* yellow  */
  [12] = "#01a0e4", /* blue    */
  [13] = "#a16a94", /* magenta */
  [14] = "#b5e4f4", /* cyan    */
  [15] = "#f7f7f7", /* white   */

  /* special colors */
  [256] = "#f7f7f7", /* background */
  [257] = "#4a4543", /* foreground */
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
