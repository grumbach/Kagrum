; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    idt_flush.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: agrumbac <agrumbac@student.42.fr>          +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2019/06/05 22:10:25 by agrumbac          #+#    #+#              ;
;    Updated: 2019/06/06 23:49:03 by agrumbac         ###   ########.fr        ;
;                                                                              ;
; **************************************************************************** ;

section .text
global idt_flush

idt_flush:
	mov eax, [esp+4]
	lidt [eax]
	ret
