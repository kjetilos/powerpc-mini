#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>
#include <linux/fb.h>
#include <sys/mman.h>
#include <sys/ioctl.h>
#include <stdint.h>

int main()
{
  int fbfd = 0;
  struct fb_var_screeninfo vinfo;
  struct fb_fix_screeninfo finfo;
  size_t screensize = 0;
  size_t fb_size = 0;
  char *fbp = 0;
  int x = 0, y = 0;
  long int location = 0;
  
  // Open the file for reading and writing
  fbfd = open("/dev/fb0", O_RDWR);
  if (fbfd == -1) {
    perror("Error: cannot open framebuffer device");
    exit(1);
  }
  printf("The framebuffer device was opened successfully.\n");
  
  // Get fixed screen information
  if (ioctl(fbfd, FBIOGET_FSCREENINFO, &finfo) == -1) {
    perror("Error reading fixed information");
    exit(2);
  }
  
  // Get variable screen information
  if (ioctl(fbfd, FBIOGET_VSCREENINFO, &vinfo) == -1) {
    perror("Error reading variable information");
    exit(3);
  }
  
  printf("%dx%d, %dbpp\n", vinfo.xres, vinfo.yres, vinfo.bits_per_pixel);
  
  // Figure out the size of the screen in bytes
  screensize = vinfo.xres * vinfo.yres * vinfo.bits_per_pixel / 8;
  fb_size = finfo.smem_len;
  
  // Map the device to memory
  fbp = (char *)mmap(0, fb_size, PROT_READ | PROT_WRITE, MAP_SHARED, fbfd, 0);
  if ((int)fbp == -1) {
    perror("Error: failed to map framebuffer device to memory");
    exit(4);
  }
  printf("The framebuffer device was mapped to memory successfully.\n");

  
  printf("red offset %u length %u\n", vinfo.red.offset, vinfo.red.length);
  printf("green offset %u length %u\n", vinfo.green.offset, vinfo.green.length);
  printf("blue offset %u length %u\n", vinfo.blue.offset, vinfo.blue.length);
  printf("transp offset %u length %u\n", vinfo.transp.offset, vinfo.transp.length);

  uint16_t mask = 0x1f;
  uint16_t color = mask;
  uint16_t* pixel = (uint16_t *)fbp;
  for (size_t i = 0; i<(screensize/2); i++) {
    pixel[i] = color;
  }

  munmap(fbp, fb_size);
  close(fbfd);
  return 0;
}
