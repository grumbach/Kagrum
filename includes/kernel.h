/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   kernel.h                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: agrumbac <agrumbac@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/05/12 16:03:17 by agrumbac          #+#    #+#             */
/*   Updated: 2019/06/05 00:28:43 by agrumbac         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef KERNEL_H
# define KERNEL_H

# include <stdbool.h>
# include <stddef.h>
# include <stdint.h>

/*
** kernel
*/

void		gdt_init(void);
void		keyboard_init(void);

/*
** terminal
*/

void		terminal_init(void);
void		terminal_putchar(unsigned char c);
void		terminal_putstr(char *str);

/*
** utils
*/

void		sleep(size_t time);
size_t		strlen(const char *str);

#endif
