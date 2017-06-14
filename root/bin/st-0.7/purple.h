
/* Terminal colors (16 first used in escape sequence) */
static const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#20111c", /* black   */
  [1] = "#2b1826", /* red     */
  [2] = "#41273a", /* green   */
  [3] = "#603c56", /* yellow  */
  [4] = "#865579", /* blue    */
  [5] = "#b475a4", /* magenta */
  [6] = "#d0a7c4", /* cyan    */
  [7] = "#eddfe8", /* white   */

  /* 8 bright colors */
  [8]  = "#ef9784", /* black   */
  [9]  = "#f27753", /* red     */
  [10] = "#63afb6", /* green   */
  [11] = "#62b2ba", /* yellow  */
  [12] = "#72d49a", /* blue    */
  [13] = "#f2896f", /* magenta */
  [14] = "#9ca6f2", /* cyan    */
  [15] = "#95a0f2", /* white   */

  /* special colors */
  [256] = "#140911", /* background */
  [257] = "#e0c8d9", /* foreground */
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
