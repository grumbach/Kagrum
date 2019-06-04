# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: agrumbac <agrumbac@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2016/11/04 17:08:23 by agrumbac          #+#    #+#              #
#    Updated: 2019/06/05 00:21:56 by agrumbac         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

############################## VAR #############################################

NAME = Kagrum

AS = nasm

ASFLAGS = -f elf

CC = i686-elf-gcc

CPPFLAGS = -Iincludes/

CFLAGS = -fno-builtin -fno-exceptions -fno-stack-protector \
	-nostdlib -nodefaultlibs \
	-std=gnu99 -ffreestanding  -Wall -Wextra -Ilibft/includes

LDFLAGS = -ffreestanding -nostdlib -lgcc

############################## SRC #############################################

SRC = boot/boot.s \
	kernel/gdt_flush.s \
	kernel/gdt.c \
	kernel/kernel.c \
	kernel/keyboard_handler.c \
	kernel/keyboard.s \
	kernel/kfs_utils.c \
	kernel/terminal.c

COBJ = $(SRC:.c=.o)
OBJ = $(COBJ:.s=.o)

############################## COLORS ##########################################

BY = "\033[33;1m"
BR = "\033[31;1m"
BG = "\033[32;1m"
BB = "\033[34;1m"
BM = "\033[35;1m"
BC = "\033[36;1m"
BW = "\033[37;1m"
Y = "\033[33m"
R = "\033[31m"
G = "\033[32m"
B = "\033[34m"
M = "\033[35m"
C = "\033[36m"
W = "\033[0m""\033[32;1m"
WR = "\033[0m""\033[31;5m"
WY = "\033[0m""\033[33;5m"
X = "\033[0m"

############################## BUILD ###########################################

all: art ${NAME}

libft/%.a:
	make -C libft

${NAME}: ${LIB} ${OBJ}
	i686-elf-gcc -T linker.ld ${LDFLAGS} -o ${NAME} ${OBJ}

############################## MORE ############################################

check:
	@grub-file --is-x86-multiboot ${NAME} && echo ${B}[${NAME}] ${G}Multiboot OK!${X} || echo ${B}[${NAME}] ${R}NOT Multiboot${X}

iso: art ${NAME}
	$(shell printf 'menuentry "${NAME}" {\n\
	\tmultiboot /boot/${NAME}\n\
	}\n' > grub.cfg)
	/bin/mkdir -p isodir/boot/grub
	/bin/cp Kagrum isodir/boot/Kagrum
	/bin/cp grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o ${NAME}.iso isodir

run: ${NAME}
	qemu-system-i386 -kernel Kagrum -curses

debug: ${NAME}
	qemu-system-i386 -kernel Kagrum -curses -s -S

clean:
	make -C libft clean
	@echo ${R}Cleaning...${X}
	/bin/rm -f ${OBJ}
	/bin/rm -rf isodir
	/bin/rm -f grub.cfg
	/bin/rm -f ${NAME}.iso

fclean: clean
	make -C libft fclean
	@echo ${R}Cleaning"  "[${NAME}]...${X}
	/bin/rm -f ${NAME}

re:
	$(MAKE) fclean
	$(MAKE) all

############################## ART #############################################

art:
	@echo ${BG}"ASCIIART"${X}

.PHONY: all clean fclean re iso check art