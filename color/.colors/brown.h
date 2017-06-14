/* Terminal colors (16 first used in escape sequence) */
static const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#110907", /* black   */
  [1] = "#1f1411", /* red     */
  [2] = "#352520", /* green   */
  [3] = "#533b35", /* yellow  */
  [4] = "#79584f", /* blue    */
  [5] = "#a77b6f", /* magenta */
  [6] = "#cda9a0", /* cyan    */
  [7] = "#ebe0de", /* white   */

  /* 8 bright colors */
  [8]  = "#60acb7", /* black   */
  [9]  = "#a6a76b", /* red     */
  [10] = "#da89c0", /* green   */
  [11] = "#5eb086", /* yellow  */
  [12] = "#efa0d5", /* blue    */
  [13] = "#e0a4cb", /* magenta */
  [14] = "#acac6b", /* cyan    */
  [15] = "#7dbe9a", /* white   */

  /* special colors */
  [256] = "#090504", /* background */
  [257] = "#e6d7d4", /* foreground */
};

/*
 * Default colors (colorname index)
 * foreground, background, cursor
 */
static unsigned int defaultfg = 257;
static unsigned int defaultbg = 256;
static unsigned int defaultcs = 257;
static unsigned int defaultrcs = 257;

/*
 * Colors used, when the specific fg == defaultfg. So in reverse mode this
 * will reverse too. Another logic would only make the simple feature too
 * complex.
 */
static unsigned int defaultitalic = 7;
static unsigned int defaultunderline = 7;
