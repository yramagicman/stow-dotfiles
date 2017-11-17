/* Terminal colors (16 first used in escape sequence) */
const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#131513", /* black   */
  [1] = "#e6193c", /* red     */
  [2] = "#29a329", /* green   */
  [3] = "#c3c322", /* yellow  */
  [4] = "#3d62f5", /* blue    */
  [5] = "#ad2bee", /* magenta */
  [6] = "#1999b3", /* cyan    */
  [7] = "#8ca68c", /* white   */

  /* 8 bright colors */
  [8]  = "#202620", /* black   */
  [9]  = "#e6193c", /* red     */
  [10] = "#29a329", /* green   */
  [11] = "#c3c322", /* yellow  */
  [12] = "#3d62f5", /* blue    */
  [13] = "#ad2bee", /* magenta */
  [14] = "#1999b3", /* cyan    */
  [15] = "#f0fff0", /* white   */

  /* special colors */
  [256] = "#131513", /* background */
  [257] = "#8ca68c", /* foreground */
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
