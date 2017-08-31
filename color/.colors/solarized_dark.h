/* Terminal colors (16 first used in escape sequence) */
const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#002b36", /* black   */
  [1] = "#dc322f", /* red     */
  [2] = "#859900", /* green   */
  [3] = "#b58900", /* yellow  */
  [4] = "#268bd2", /* blue    */
  [5] = "#6c71c4", /* magenta */
  [6] = "#2aa198", /* cyan    */
  [7] = "#93a1a1", /* white   */

  /* 8 bright colors */
  [8]  = "#657b83", /* black   */
  [9]  = "#dc322f", /* red     */
  [10] = "#859900", /* green   */
  [11] = "#b58900", /* yellow  */
  [12] = "#268bd2", /* blue    */
  [13] = "#6c71c4", /* magenta */
  [14] = "#2aa198", /* cyan    */
  [15] = "#fdf6e3", /* white   */

  /* special colors */
  [256] = "#002b36", /* background */
  [257] = "#93a1a1", /* foreground */
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
