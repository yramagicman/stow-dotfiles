/* Terminal colors (16 first used in escape sequence) */
const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#101110", /* black   */
  [1] = "#1a1b19", /* red     */
  [2] = "#2b2d2a", /* green   */
  [3] = "#424541", /* yellow  */
  [4] = "#60645e", /* blue    */
  [5] = "#848981", /* magenta */
  [6] = "#adb4aa", /* cyan    */
  [7] = "#dde5d9", /* white   */

  /* 8 bright colors */
  [8]  = "#d09d3f", /* black   */
  [9]  = "#8adf27", /* red     */
  [10] = "#f88eac", /* green   */
  [11] = "#95cdf5", /* yellow  */
  [12] = "#fbbfce", /* blue    */
  [13] = "#cf87e9", /* magenta */
  [14] = "#53c3ff", /* cyan    */
  [15] = "#81d317", /* white   */

  /* special colors */
  [256] = "#090908", /* background */
  [257] = "#cfd7cb", /* foreground */
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
