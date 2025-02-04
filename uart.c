/* #include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <termios.h>
#include <stdint.h> // For uint8_t and uint32_t
#include <errno.h>  // For errno
#include <time.h>   // For nanosleep
#include <sys/select.h> // For fd_set, select, and struct timeval
#include <string.h>

int main() {
    int fd;
    struct termios options;
    char text[256];
    int len; // Typically, `read` returns an integer

    // Open the serial port
    fd = open("/dev/serial0", O_RDWR | O_NDELAY | O_NOCTTY);
    if (fd < 0) {
        perror("Error opening serial port");
        return -1;
    }
    // Configure the UART
    tcgetattr(fd, &options);           // Get current settings
    cfsetispeed(&options, B9600);      // Set input baud rate
    cfsetospeed(&options, B9600);      // Set output baud rate
    options.c_cflag = CS8 | CLOCAL | CREAD; // 8 data bits, local connection, enable receiver
    options.c_iflag = IGNPAR;          // Ignore framing and parity errors
    options.c_oflag = 0;               // No output processing
    options.c_lflag = 0;               // No local processing
    tcflush(fd, TCIFLUSH);             // Flush the input buffer
    tcsetattr(fd, TCSANOW, &options);  // Apply the settings

    // Variables to store user inputs
    uint32_t hex_value1, hex_value2;

    // Take input for the first 32-bit hexadecimal value
    printf("Enter the first 32-bit hexadecimal value (e.g., 1234ABCD): ");
    scanf("%x", &hex_value1);

    // Take input for the second 32-bit hexadecimal value
    printf("Enter the second 32-bit hexadecimal value (e.g., 89ABCDEF): ");
    scanf("%x", &hex_value2);

    // Split the first 32-bit value into 8-bit chunks
    uint8_t bytes1[4];
    bytes1[0] = (hex_value1 >> 24) & 0xFF; // Most significant byte
    bytes1[1] = (hex_value1 >> 16) & 0xFF;
    bytes1[2] = (hex_value1 >> 8) & 0xFF;
    bytes1[3] = hex_value1 & 0xFF;         // Least significant byte

    // Split the second 32-bit value into 8-bit chunks
    uint8_t bytes2[4];
    bytes2[0] = (hex_value2 >> 24) & 0xFF; // Most significant byte
    bytes2[1] = (hex_value2 >> 16) & 0xFF;
    bytes2[2] = (hex_value2 >> 8) & 0xFF;
    bytes2[3] = hex_value2 & 0xFF;         // Least significant byte

    // Send the first 32-bit value over UART
    int len1 = write(fd, bytes1, 4); // Send all 4 bytes of the first value
    if (len1 < 0) {
        perror("Error writing first value to serial port");
    } else {
        printf("Sent 1st 32-bit hex value: 0x%08X\n", hex_value1);
    }

    // Send the second 32-bit value over UART
    int len2 = write(fd, bytes2, 4); // Send all 4 bytes of the second value
    if (len2 < 0) {
        perror("Error writing second value to serial port");
    } else {
        printf("Sent 2nd 32-bit hex value: 0x%08X\n", hex_value2);
    }

    // Notify user and wait for input
    printf("You have 5 seconds to send me some input data...\n");
    sleep(5);

    // Read from the UART
    memset(text, 0, sizeof(text)); // Clear the buffer
    len = read(fd, text, sizeof(text) - 1);
    if (len < 0) {
        perror("Error reading from UART");
    } else if (len == 0) {
        printf("No data received.\n");
    } else {
        printf("Received %d bytes\n", len);
        printf("Received string: %s\n", text);
    }

    
    close(fd);
    return 0;
}
*/

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <termios.h>
#include <errno.h>

// Function to print binary format of a 32-bit value
void print_binary(unsigned int n) {
    for (int i = 31; i >= 0; i--) {
        printf("%d", (n >> i) & 1);
        if (i % 4 == 0 && i != 0) {
            printf(" "); // Add space every 4 bits for readability
        }
    }
    printf("\n");
}

// Function to configure the UART port
int configure_uart(const char *device) {
    int fd = open(device, O_RDWR | O_NOCTTY); // Use blocking mode (remove O_NDELAY)
    if (fd == -1) {
        perror("Error opening UART");
        return -1;
    }

    struct termios options;
    tcgetattr(fd, &options);

    cfsetispeed(&options, B9600);
    cfsetospeed(&options, B9600);

    options.c_cflag = (options.c_cflag & ~CSIZE) | CS8; // 8 data bits
    options.c_iflag = IGNPAR;                          // Ignore parity
    options.c_oflag = 0;                               // Raw output
    options.c_lflag = 0;                               // Non-canonical mode

    options.c_cflag |= (CLOCAL | CREAD);               // Enable receiver
    options.c_cc[VMIN]  = 1;                           // Minimum number of characters
    options.c_cc[VTIME] = 1;                           // Timeout in tenths of seconds

    tcflush(fd, TCIFLUSH);
    if (tcsetattr(fd, TCSANOW, &options) != 0) {
        perror("Error setting terminal attributes");
        close(fd);
        return -1;
    }

    return fd;
}

// Function to send data
void send_data(int fd) {
    uint32_t hex_value1, hex_value2;

    // Get two 32-bit hexadecimal values from the user
    printf("Enter the first 32-bit hex value to send: ");
    scanf("%x", &hex_value1);
    printf("Enter the second 32-bit hex value to send: ");
    scanf("%x", &hex_value2);

    uint8_t bytes1[4] = {
        (hex_value1 >> 24) & 0xFF,
        (hex_value1 >> 16) & 0xFF,
        (hex_value1 >> 8) & 0xFF,
        hex_value1 & 0xFF
    };

    uint8_t bytes2[4] = {
        (hex_value2 >> 24) & 0xFF,
        (hex_value2 >> 16) & 0xFF,
        (hex_value2 >> 8) & 0xFF,
        hex_value2 & 0xFF
    };

    // Send the first data
    if (write(fd, bytes1, 4) != 4) {
        perror("Error sending first data");
    } else {
        printf("Sent first data: 0x%08X\n", hex_value1);
    }

    // Send the second data
    if (write(fd, bytes2, 4) != 4) {
        perror("Error sending second data");
    } else {
        printf("Sent second data: 0x%08X\n", hex_value2);
    }
}

// Function to receive data
void receive_data(int fd) {
    uint8_t buffer[4];
    printf("You have 5 seconds to send me some input data...\n");
    sleep(5);
    ssize_t len = read(fd, buffer, 4); // Read 4 bytes (32-bit data)
    if (len == 4) {
        uint32_t value = (buffer[3] << 24) |
                         (buffer[2] << 16) |
                         (buffer[1] << 8) |
                         buffer[0];

       printf("Received 32-bit value (Decimal): %u\n", value);
       printf("Received 32-bit value (Hexadecimal): 0x%08X\n", value);
       printf("Received 32-bit value (Binary): ");
       print_binary(value);
    } else if (len > 0) {
        printf("Partial data received (%zd bytes). Waiting for more...\n", len);
	        uint32_t received_value = (buffer[0] & 0xFF) | 
                             ((buffer[1] & 0xFF) << 8) | 
                             ((buffer[2] & 0xFF) << 16) | 
                             ((buffer[3] & 0xFF) << 24);
	    printf("Received 32-bit value (Decimal): %u\n", received_value);
            printf("Received 32-bit value (Hexadecimal): 0x%08X\n", received_value);
            printf("Received 32-bit value (Binary): ");
            print_binary(received_value);
     } else if (len == 0) {
        printf("No data available.\n");
    } else {
        perror("Error reading data");
    }
}

int main() {
    const char *device = "/dev/serial0"; // Adjust as needed for your system
    int fd = configure_uart(device);
    if (fd == -1) {
        return -1;
    }

    // Send two 32-bit numbers
    send_data(fd);

    // Receive the processed 32-bit value
    receive_data(fd);

    close(fd);
    return 0;
}
