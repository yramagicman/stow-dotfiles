/* Terminal colors (16 first used in escape sequence) */
static const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#161b1d", /* black   */
  [1] = "#d22d72", /* red     */
  [2] = "#568c3b", /* green   */
  [3] = "#8a8a0f", /* yellow  */
  [4] = "#257fad", /* blue    */
  [5] = "#5d5db1", /* magenta */
  [6] = "#2d8f6f", /* cyan    */
  [7] = "#7ea2b4", /* white   */

  /* 8 bright colors */
  [8]  = "#5a7b8c", /* black   */
  [9]  = "#d22d72", /* red     */
  [10] = "#568c3b", /* green   */
  [11] = "#8a8a0f", /* yellow  */
  [12] = "#257fad", /* blue    */
  [13] = "#5d5db1", /* magenta */
  [14] = "#2d8f6f", /* cyan    */
  [15] = "#ebf8ff", /* white   */

  /* special colors */
  [256] = "#161b1d", /* background */
  [257] = "#7ea2b4", /* foreground */
};

/*
 * Default colors (colorname index)
 * foreground, background, cursor
 */
static unsigned int defaultfg = 257;
static unsigned int defaultbg = 256;
static unsigned int defaultcs = 257;
static unsigned int defaultrcs = 256;

/*
 * Colors used, when the specific fg == defaultfg. So in reverse mode this
 * will reverse too. Another logic would only make the simple feature too
 * complex.
 */
static unsigned int defaultitalic = 7;
static unsigned int defaultunderline = 7;
