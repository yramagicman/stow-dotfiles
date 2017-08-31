/* Terminal colors (16 first used in escape sequence) */
const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#120c15", /* black   */
  [1] = "#1f1622", /* red     */
  [2] = "#322538", /* green   */
  [3] = "#4e3c56", /* yellow  */
  [4] = "#71587c", /* blue    */
  [5] = "#9a7ba7", /* magenta */
  [6] = "#beabc7", /* cyan    */
  [7] = "#e7e0ea", /* white   */

  /* 8 bright colors */
  [8]  = "#d898f2", /* black   */
  [9]  = "#e8cef5", /* red     */
  [10] = "#e8bcfb", /* green   */
  [11] = "#88c453", /* yellow  */
  [12] = "#71f8e2", /* blue    */
  [13] = "#80edda", /* magenta */
  [14] = "#93d1fa", /* cyan    */
  [15] = "#efdcf9", /* white   */

  /* special colors */
  [256] = "#0a060c", /* background */
  [257] = "#ddd4e2", /* foreground */
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
