/* Terminal colors (16 first used in escape sequence) */
const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#20201d", /* black   */
  [1] = "#d73737", /* red     */
  [2] = "#60ac39", /* green   */
  [3] = "#cfb017", /* yellow  */
  [4] = "#6684e1", /* blue    */
  [5] = "#b854d4", /* magenta */
  [6] = "#1fad83", /* cyan    */
  [7] = "#a6a28c", /* white   */

  /* 8 bright colors */
  [8]  = "#7d7a68", /* black   */
  [9]  = "#d73737", /* red     */
  [10] = "#60ac39", /* green   */
  [11] = "#cfb017", /* yellow  */
  [12] = "#6684e1", /* blue    */
  [13] = "#b854d4", /* magenta */
  [14] = "#1fad83", /* cyan    */
  [15] = "#fefbec", /* white   */

  /* special colors */
  [256] = "#fefbec", /* background */
  [257] = "#6e6b5e", /* foreground */
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
