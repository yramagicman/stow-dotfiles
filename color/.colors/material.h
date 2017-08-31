/* Terminal colors (16 first used in escape sequence) */
const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#263238", /* black   */
  [1] = "#ff9800", /* red     */
  [2] = "#8bc34a", /* green   */
  [3] = "#ffc107", /* yellow  */
  [4] = "#03a9f4", /* blue    */
  [5] = "#e91e63", /* magenta */
  [6] = "#009688", /* cyan    */
  [7] = "#cfd8dc", /* white   */

  /* 8 bright colors */
  [8]  = "#37474f", /* black   */
  [9]  = "#ffa74d", /* red     */
  [10] = "#9ccc65", /* green   */
  [11] = "#ffa000", /* yellow  */
  [12] = "#81d4fa", /* blue    */
  [13] = "#ad1457", /* magenta */
  [14] = "#26a69a", /* cyan    */
  [15] = "#eceff1", /* white   */

  /* special colors */
  [256] = "#263238", /* background */
  [257] = "#eceff1", /* foreground */
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
