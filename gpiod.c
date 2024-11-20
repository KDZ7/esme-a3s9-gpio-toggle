#include <gpiod.h>
#include <stdio.h>
#include <unistd.h>

#define CHIP_NAME "gpiochip0"
#define GPIO_LINE 17

int main() {
    struct gpiod_chip *chip;
    struct gpiod_line *line;
    int value = 0;

    // Ouvrir le chip GPIO
    chip = gpiod_chip_open_by_name(CHIP_NAME);
    if (!chip) {
        perror("Échec d'ouverture du chip GPIO");
        return 1;
    }

    // Obtenir la ligne GPIO
    line = gpiod_chip_get_line(chip, GPIO_LINE);
    if (!line) {
        perror("Échec d'obtention de la ligne GPIO");
        gpiod_chip_close(chip);
        return 1;
    }

    // Demander la ligne en tant que sortie
    if (gpiod_line_request_output(line, "gpio_toggle", 0) < 0) {
        perror("Échec de la demande de la ligne en tant que sortie");
        gpiod_chip_close(chip);
        return 1;
    }

    // Boucle infinie pour basculer la LED
    while (1) {
        value = !value; // Inverser la valeur
        gpiod_line_set_value(line, value);
        sleep(1); // Attendre une seconde
    }

    // Libérer les ressources
    gpiod_line_release(line);
    gpiod_chip_close(chip);

    return 0;
}

