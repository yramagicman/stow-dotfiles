/* Terminal colors (16 first used in escape sequence) */
const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#000000", /* black   */
  [1] = "#e6193c", /* red     */
  [2] = "#29a329", /* green   */
  [3] = "#c3c322", /* yellow  */
  [4] = "#3d62f5", /* blue    */
  [5] = "#ad2bee", /* magenta */
  [6] = "#1999b3", /* cyan    */
  [7] = "#adadad", /* white   */

  /* 8 bright colors */
  [8]  = "#555555", /* black   */
  [9]  = "#ff4060", /* red     */
  [10] = "#45bf45", /* green   */
  [11] = "#dede38", /* yellow  */
  [12] = "#5273f5", /* blue    */
  [13] = "#b544ee", /* magenta */
  [14] = "#2aa7c1", /* cyan    */
  [15] = "#d0d0d0", /* white   */

  /* special colors */
  [256] = "#000000", /* background */
  [257] = "#adadad", /* foreground */
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
