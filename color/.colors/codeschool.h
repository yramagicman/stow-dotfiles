
/* Terminal colors (16 first used in escape sequence) */
static const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#232c31", /* black   */
  [1] = "#2a5491", /* red     */
  [2] = "#237986", /* green   */
  [3] = "#a03b1e", /* yellow  */
  [4] = "#484d79", /* blue    */
  [5] = "#c59820", /* magenta */
  [6] = "#b02f30", /* cyan    */
  [7] = "#9ea7a6", /* white   */

  /* 8 bright colors */
  [8]  = "#3f4944", /* black   */
  [9]  = "#2a5491", /* red     */
  [10] = "#237986", /* green   */
  [11] = "#a03b1e", /* yellow  */
  [12] = "#484d79", /* blue    */
  [13] = "#c59820", /* magenta */
  [14] = "#b02f30", /* cyan    */
  [15] = "#b5d8f6", /* white   */

  /* special colors */
  [256] = "#232c31", /* background */
  [257] = "#9ea7a6", /* foreground */
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
