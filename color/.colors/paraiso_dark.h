/* Terminal colors (16 first used in escape sequence) */
const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#2f1e2e", /* black   */
  [1] = "#ef6155", /* red     */
  [2] = "#48b685", /* green   */
  [3] = "#fec418", /* yellow  */
  [4] = "#06b6ef", /* blue    */
  [5] = "#815ba4", /* magenta */
  [6] = "#5bc4bf", /* cyan    */
  [7] = "#a39e9b", /* white   */

  /* 8 bright colors */
  [8]  = "#776e71", /* black   */
  [9]  = "#ef6155", /* red     */
  [10] = "#48b685", /* green   */
  [11] = "#fec418", /* yellow  */
  [12] = "#06b6ef", /* blue    */
  [13] = "#815ba4", /* magenta */
  [14] = "#5bc4bf", /* cyan    */
  [15] = "#e7e9db", /* white   */

  /* special colors */
  [256] = "#2f1e2e", /* background */
  [257] = "#a39e9b", /* foreground */
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
