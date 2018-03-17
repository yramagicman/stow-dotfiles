/* Terminal colors (16 first used in escape sequence) */
const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#231f20", /* black   */
  [1] = "#ee2e24", /* red     */
  [2] = "#00853e", /* green   */
  [3] = "#ffd204", /* yellow  */
  [4] = "#009ddc", /* blue    */
  [5] = "#98005d", /* magenta */
  [6] = "#85cebc", /* cyan    */
  [7] = "#d9d8d8", /* white   */

  /* 8 bright colors */
  [8]  = "#737171", /* black   */
  [9]  = "#ee2e24", /* red     */
  [10] = "#00853e", /* green   */
  [11] = "#ffd204", /* yellow  */
  [12] = "#009ddc", /* blue    */
  [13] = "#98005d", /* magenta */
  [14] = "#85cebc", /* cyan    */
  [15] = "#ffffff", /* white   */

  /* special colors */
  [256] = "#231f20", /* background */
  [257] = "#d9d8d8", /* foreground */
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
