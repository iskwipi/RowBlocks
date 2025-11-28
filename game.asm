; Preprocess Section
BITS 16
ORG 0x100

; Constant Declarations
SCREEN_WIDTH        equ 320
SCREEN_HEIGHT       equ 200
FRAME_DELAY         equ 16666
VGA_INPUT_STATUS_1  equ 0x3DA
VRETRACE_BIT        equ 0x08
KEY_A_SCAN_CODE     equ 0x1E
KEY_D_SCAN_CODE     equ 0x20
KEY_ESC_SCAN_CODE   equ 0x01

; Data Declarations
segment .data
heart_bitmap:
    db 0, 1, 1, 0, 1, 1, 0
    db 1, 1, 1, 1, 1, 1, 1
    db 1, 1, 1, 1, 1, 1, 1
    db 0, 1, 1, 1, 1, 1, 0
    db 0, 0, 1, 1, 1, 0, 0
    db 0, 0, 0, 1, 0, 0, 0
number_bitmap:
    ; 0
    db 0, 1, 1, 0
    db 1, 0, 0, 1
    db 1, 0, 1, 1
    db 1, 1, 0, 1
    db 1, 0, 0, 1
    db 0, 1, 1, 0
    ; 1
    db 0, 0, 1, 0
    db 0, 1, 1, 0
    db 0, 0, 1, 0
    db 0, 0, 1, 0
    db 0, 0, 1, 0
    db 0, 1, 1, 1
    ; 2
    db 0, 1, 1, 0
    db 1, 0, 0, 1
    db 0, 0, 0, 1
    db 0, 1, 1, 1
    db 1, 0, 0, 0
    db 1, 1, 1, 1
    ; 3
    db 0, 1, 1, 0
    db 1, 0, 0, 1
    db 0, 0, 1, 0
    db 0, 0, 0, 1
    db 1, 0, 0, 1
    db 0, 1, 1, 0
    ; 4
    db 0, 0, 1, 0
    db 0, 1, 1, 0
    db 1, 0, 1, 0
    db 1, 1, 1, 1
    db 0, 0, 1, 0
    db 0, 0, 1, 0
    ; 5
    db 1, 1, 1, 1
    db 1, 0, 0, 0
    db 1, 1, 1, 0
    db 0, 0, 0, 1
    db 1, 0, 0, 1
    db 0, 1, 1, 0
    ; 6
    db 0, 1, 1, 0
    db 1, 0, 0, 0
    db 1, 1, 1, 0
    db 1, 0, 0, 1
    db 1, 0, 0, 1
    db 0, 1, 1, 0
    ; 7
    db 1, 1, 1, 1
    db 0, 0, 0, 1
    db 0, 0, 1, 0
    db 0, 1, 0, 0
    db 0, 1, 0, 0
    db 0, 1, 0, 0
    ; 8
    db 0, 1, 1, 0
    db 1, 0, 0, 1
    db 0, 1, 1, 0
    db 1, 0, 0, 1
    db 1, 0, 0, 1
    db 0, 1, 1, 0
    ; 9
    db 0, 1, 1, 0
    db 1, 0, 0, 1
    db 1, 0, 0, 1
    db 0, 1, 1, 1
    db 0, 0, 0, 1
    db 0, 1, 1, 0
block_color_bitmap:
    db 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00
    db 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00
    db 00, 40, 40, 40, 40, 40, 40, 40, 40, 40, 00
    db 00, 42, 42, 42, 42, 42, 42, 42, 42, 42, 00
    db 00, 44, 44, 44, 44, 44, 44, 44, 44, 44, 00
    db 00, 48, 48, 48, 48, 48, 48, 48, 48, 48, 00
    db 00, 52, 52, 52, 52, 52, 52, 52, 52, 52, 00
current_color:
    db 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00
    db 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00
    db 00, 40, 40, 40, 40, 40, 40, 40, 40, 40, 00
    db 00, 42, 42, 42, 42, 42, 42, 42, 42, 42, 00
    db 00, 44, 44, 44, 44, 44, 44, 44, 44, 44, 00
    db 00, 48, 48, 48, 48, 48, 48, 48, 48, 48, 00
    db 00, 52, 52, 52, 52, 52, 52, 52, 52, 52, 00
level_bitmap:
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0
    db 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0
    db 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0
    db 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0
    db 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100
current_level:
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0
    db 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0
    db 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0
    db 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0
    db 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100
old_int09_ip:   dw  0
old_int09_cs:   dw  0
any_key_state:  db  0
key_state_a:    db  0
key_state_d:    db  0
key_state_esc:  db  0
paddle_x:       dw  160
paddle_y:       dw  184
paddle_half_w:  db  16
paddle_half_h:  db  2
paddle_color:   db  15
paddle_speed:   db  100
ball_x:         dw  160
ball_y:         dw  178
ball_r:         db  2
ball_color:     db  15
ball_x_speed:   db  102
ball_y_speed:   db  102
left_bound:     dw  0
right_bound:    dw  0
top_bound:      dw  0
bottom_bound:   dw  0
prev_ball_x:    dw  0
prev_ball_y:    dw  0
block_x:        dw  0
block_y:        dw  0
game_paused:    db  1
lives_left:     db  3
current_score:  db  0
blocks_left:    db  45

; -------------------- MAIN PROGRAM --------------------
segment .text
PRESETUP:
    call BUILD_SETUP
    call INSTALL_ISR

MAIN:
    call DRAW_LEVEL

.game_loop:
    call HANDLE_INPUT

    call UPDATE_PADDLE
    call UPDATE_PADDLE_SPEED
    call UPDATE_BALL_POSITION
    
    call CHECK_WALL_COLLISIONS
    call CHECK_PADDLE_COLLISION
    call CHECK_LEVEL_COLLISION
    
    call WAIT_FOR_VRETRACE
    call ERASE_BALL
    call REDRAW_BALL

    ; call DELAY_FRAME
    jmp .game_loop
    
.failsafe:
    call RESTORE_ISR
    call CLEAR_SETUP


; -------------------- PROGRAM FUNCTIONS --------------------
BUILD_SETUP:
    ; Change to video mode 13h
    mov ax, 0x0013
    int 10h

    ; Point ES to graphics memory
    mov ax, 0xA000
    mov es, ax
    ret


CLEAR_SETUP:
    ; Return to text mode
    mov ax, 0x0003
    int 0x10

    ; Terminate program
    mov ax, 0x4C00
    int 0x21
    ret


KEYBOARD_ISR:
    push ax
    push dx
    
    ; Read scan code from keyboard data port
    in al, 0x60

    ; Determine if key is pressed or released
    test al, 0x80
    jnz .key_release
    mov byte [any_key_state], 1
    
.check_esc:
    cmp al, KEY_ESC_SCAN_CODE
    jne .check_a
    mov byte [key_state_esc], 1
    jmp .end

.check_a:
    cmp al, KEY_A_SCAN_CODE
    jne .check_d
    mov byte [key_state_a], 1
    jmp .end

.check_d:
    cmp al, KEY_D_SCAN_CODE
    jne .end
    mov byte [key_state_d], 1
    jmp .end

.key_release:
    ; Apply mask to get original scan code
    and al, 0x7F
    mov byte [any_key_state], 0

.check_esc_release:
    cmp al, KEY_ESC_SCAN_CODE
    jne .check_a_release
    mov byte [key_state_esc], 0
    jmp .end
    
.check_a_release:
    cmp al, KEY_A_SCAN_CODE
    jne .check_d_release
    mov byte [key_state_a], 0
    jmp .end

.check_d_release:
    cmp al, KEY_D_SCAN_CODE
    jne .end
    mov byte [key_state_d], 0
    
.end:
    ; Acknowledge the keyboard interrupt
    mov al, 0x20
    out 0x20, al
    pop dx
    pop ax
    iret


INSTALL_ISR:
    ; Setup access to interrupt vector table
    push ds
    xor ax, ax
    mov ds, ax
    
    ; Save the original vector
    mov ax, [9 * 4]
    mov [old_int09_cs], ax
    mov ax, [9 * 4 + 2]
    mov [old_int09_ip], ax
    
    ; Install the new vector
    mov dx, KEYBOARD_ISR
    mov ax, cs
    mov ds, ax
    mov al, 0x09
    mov ah, 0x25
    int 0x21
    
    ; Return to main program
    pop ds
    ret


RESTORE_ISR:
    ; Setup access to interrupt vector table
    push ds
    xor ax, ax
    mov ds, ax
    
    ; Restore the original vector
    mov ax, [old_int09_cs]
    mov [9 * 4], ax
    mov ax, [old_int09_ip]
    mov [9 * 4 + 2], ax

    ; Return to main program
    pop ds
    ret


WAIT_FOR_VRETRACE:
    ; Get input status register for V-Retrace bit
    mov dx, VGA_INPUT_STATUS_1

.wait_retrace_end:
    ; Wair for V-Retrace to finish
    in al, dx
    and al, VRETRACE_BIT
    jnz .wait_retrace_end
    
.wait_retrace_start:
    ; Wait for pixel drawing to finish
    in al, dx
    and al, VRETRACE_BIT
    jz .wait_retrace_start

.end:
    ; Start writing to memory on V-Retrace start
    ret


DELAY_FRAME:
    ; Delay loop by CX:DX microseconds
    mov ah, 0x86
    mov cx, 0x0000
    mov dx, FRAME_DELAY
    int 0x15
    ret


HANDLE_INPUT:
    ; Valid inputs
    cmp byte [key_state_esc], 1
    je .ESC_key

    cmp byte [key_state_a], 1
    je .LEFT_key

    cmp byte [key_state_d], 1
    je .RIGHT_key

    jmp .key_processed

.ESC_key:
    call RESTORE_ISR
    call CLEAR_SETUP
    jmp .key_processed

.LEFT_key:
    mov al, [paddle_speed]
    cmp al, 94
    jle .min_speed
    sub al, 3
.min_speed:
    mov [paddle_speed], al
    jmp .key_processed

.RIGHT_key:
    mov al, [paddle_speed]
    cmp al, 106
    jge .max_speed
    add al, 3
.max_speed:
    mov [paddle_speed], al
    jmp .key_processed

.key_processed:
.no_key:
    ret


GET_PIXEL_OFFSET:
    ; Input:
    ; - CX = X coordinate (0-319)
    ; - DX = Y coordinate (0-199)
    ; Output:
    ; - DI = VRAM offset (Y * 320 + X)
    mov ax, dx
    mov bx, 320
    mul bx
    add ax, cx
    mov di, ax
    ret


DRAW_PIXEL:
    ; Input:
    ; - CX = X coordinate (0-319)
    ; - DX = Y coordinate (0-199)
    ; - AL = Color value (0-255)
    push ax
    call GET_PIXEL_OFFSET
    pop ax
    mov [es:di], al
    ret


DRAW_RECTANGLE:
    ; Input:
    ; - AX = Leftmost X coordinate
    ; - BX = Topmost Y coordinate
    ; - CX = Rectangle width
    ; - DH = Rectangle height
    ; - DL = Color value
    push bp
    mov bp, sp
    push ax
    push cx
    mov di, bx
    xor cx, cx
    mov cl, dh
    xor dh, dh

.draw_row_loop:
    push cx
    mov si, [bp-2]
    mov cx, [bp-4]
    
.draw_col_loop:
    pusha
    mov ax, dx
    mov cx, si
    mov dx, di
    call DRAW_PIXEL
    popa
    inc si
    loop .draw_col_loop
    pop cx
    inc di
    loop .draw_row_loop

.end:
    pop cx
    pop ax
    pop bp
    ret


DRAW_BORDER:
    mov dl, 15

.top:
    mov ax, 0
    mov bx, 0
    mov cx, SCREEN_WIDTH
    mov dh, 1
    call DRAW_RECTANGLE

.bottom:
    mov ax, 0
    mov bx, 199
    mov cx, SCREEN_WIDTH
    mov dh, 1
    call DRAW_RECTANGLE

.left:
    mov ax, 0
    mov bx, 0
    mov cx, 1
    mov dh, SCREEN_HEIGHT
    call DRAW_RECTANGLE

.right:
    mov ax, 319
    mov bx, 0
    mov cx, 1
    mov dh, SCREEN_HEIGHT
    call DRAW_RECTANGLE
    ret


DRAW_BACKGROUND:
    mov ax, 1
    mov bx, 1
    mov cx, 318
    mov dh, 198
    mov dl, 0
    call DRAW_RECTANGLE
    ret


DRAW_HEART:
    ; Input:
    ; - CX = X coordinate
    ; - DX = Y coordinate
    ; - AL = Color value
    push ax
    push bx
    push si
    mov si, heart_bitmap
    mov bh, 6

.heart_row_loop:
    push cx
    mov bl, 7

.heart_col_loop:
    mov ah, [si]
    cmp ah, 1
    jne .next_pixel
    pusha
    call DRAW_PIXEL
    popa

.next_pixel:
    inc cx
    inc si
    dec bl
    jnz .heart_col_loop
    pop cx
    inc dx
    dec bh
    jnz .heart_row_loop

.end:
    pop si
    pop bx
    pop ax
    ret


DRAW_LIVES:
    ; Input: AL = Remaining lives
    mov cx, -4
    mov dx, 190
    shl ax, 8
    mov al, 12
    cmp ah, 0
    jle .end
    cmp ah, 3
    jle .draw_heart_loop
    mov ah, 3

.draw_heart_loop:
    add cx, 8
    pusha
    call DRAW_HEART
    popa
    dec ah
    jnz .draw_heart_loop

.end:
    ret


DRAW_NUMBER:
    ; Input:
    ; - CX = X coordinate
    ; - DX = Y coordinate
    ; - AL = Color value
    ; - BL = Number value
    push ax
    push bx
    push si
    mov bh, al
    mov al, 24
    mul bl
    mov si, number_bitmap
    xor ah, ah
    add si, ax
    mov al, bh
    mov bh, 6

.number_row_loop:
    push cx
    mov bl, 4

.number_col_loop:
    mov ah, [si]
    cmp ah, 1
    jne .next_pixel
    pusha
    call DRAW_PIXEL
    popa

.next_pixel:
    inc cx
    inc si
    dec bl
    jnz .number_col_loop
    pop cx
    inc dx
    dec bh
    jnz .number_row_loop

.end:
    pop si
    pop bx
    pop ax
    ret


DRAW_SCORE:
    ; Input: AL = Current score
    mov cx, 316
    mov dx, 190
    xor ah, ah
    mov bh, 3

.draw_digit_loop:
    sub cx, 5
    mov bl, 10
    div bl
    rol ax, 8
    mov bl, al
    mov al, 11
    pusha
    call DRAW_NUMBER
    popa
    shr ax, 8
    dec bh
    jnz .draw_digit_loop
    ret


DRAW_BLOCKS:
    mov ax, -28
    mov bx, 1
    mov si, current_color
    mov cx, 7

.row_loop:
    push cx
    mov cx, 11

.col_loop:
    push cx
    add ax, 29
    mov cx, 28
    mov dh, 8
    mov dl, [si]
    pusha
    call DRAW_RECTANGLE
    popa

.next_block:
    inc si
    pop cx
    loop .col_loop
    mov ax, -28
    add bx, 9
    pop cx
    loop .row_loop
    ret


DRAW_PADDLE:
    ; Input:
    ; - paddle_x = Center X coordinate
    ; - paddle_y = Center Y coordinate
    ; - paddle_half_w = Rectangle half-width
    ; - paddle_half_h = Rectangle half-height
    ; - DL = Color value
    pusha
    mov cl, [paddle_half_w]
    mov ax, 2
    mul cl
    add ax, 1
    mov cx, ax
    mov dh, [paddle_half_h]
    mov ax, 2
    mul dh
    add ax, 1
    mov dh, al
    push cx
    xor cx, cx
    mov cl, [paddle_half_w]
    mov ax, [paddle_x]
    sub ax, cx
    mov cl, [paddle_half_h]
    mov bx, [paddle_y]
    sub bx, cx
    pop cx
    call DRAW_RECTANGLE
    popa
    ret


DRAW_BALL:
    ; Input:
    ; - AX = Center X coordinate
    ; - BX = Center Y coordinate
    ; - DH = Ball radius
    ; - DL = Color value
    push bp
    mov bp, sp
    pusha
    mov ax, 2
    mul dh
    add ax, 1
    push ax
    mov cx, dx
    shr dx, 8
    mov ax, [bp - 2]
    sub ax, dx
    mov bx, [bp - 8]
    sub bx, dx
    mov dx, cx
    pop cx
    mov dh, cl
    call DRAW_RECTANGLE
    popa
    pop bp
    ret


DRAW_LEVEL:
    mov ax, 160
    mov [paddle_x], ax
    mov ax, 184
    mov [paddle_y], ax
    mov al, 100
    mov [paddle_speed], al
    mov ax, 160
    mov [ball_x], ax
    mov ax, 178
    mov [ball_y], ax
    mov al, 102
    mov [ball_x_speed], al
    mov al, 102
    mov [ball_y_speed], al

    call DRAW_BORDER
    call DRAW_BACKGROUND
    mov al, [lives_left]
    call DRAW_LIVES
    mov al, [current_score]
    call DRAW_SCORE
    call DRAW_BLOCKS
    mov dl, [paddle_color]
    call DRAW_PADDLE
    mov ax, [ball_x]
    mov bx, [ball_y]
    mov dh, [ball_r]
    mov dl, [ball_color]
    call DRAW_BALL

.wait_keypress:
    cmp byte [any_key_state], 1
    jne .wait_keypress
    mov byte [game_paused], 0
    ret


UPDATE_PADDLE:
    ; Input: paddle_speed
    mov dl, 0
    call DRAW_PADDLE
    xor dx, dx
    mov dl, [paddle_speed]
    mov ax, [paddle_x]
    add ax, dx
    sub ax, 100

.check_x:
    xor bh, bh
    mov bl, [paddle_half_w]
    cmp ax, bx
    jg .non_left_edge
    mov ax, bx
    inc ax
    jmp .end

.non_left_edge:
    xor ch, ch
    mov cl, [paddle_half_w]
    mov bx, 319
    sub bx, cx
    cmp ax, bx
    jl .non_right_edge
    mov ax, bx
    dec ax
    jmp .end
    
.non_right_edge:
.end:
    mov [paddle_x], ax
    mov dl, [paddle_color]
    call DRAW_PADDLE
    ret


UPDATE_PADDLE_SPEED:
    mov al, [paddle_speed]
    mov bx, [paddle_x]
    xor cx, cx
    mov cl, [paddle_half_w]

.check_edges:
    sub bx, cx
    cmp bx, 1
    jle .left_edge
    add bx, cx
    add bx, cx
    cmp bx, 318
    jge .right_edge

.deccelerate:
    cmp al, 100
    jl .negative
    jg .positive
    jmp .end

.left_edge:
    mov ah, al
    mov al, 100
    sub al, ah
    add al, 100
    jmp .end

.right_edge:
    mov ah, al
    mov al, 100
    sub ah, al
    mov al, 100
    sub al, ah
    jmp .end

.negative:
    cmp al, 99
    je .negative_one
    add al, 2
    jmp .end
.negative_one:
    add al, 1
    jmp .end

.positive:
    cmp al, 101
    je .positive_one
    sub al, 2
    jmp .end
.positive_one:
    sub al, 1
    jmp .end

.end:
    mov [paddle_speed], al
    ret


CHECK_BALL_COLLISION:
    ; Input:
    ; left_bound, right_bound,
    ; top_bound, bottom_bound,
    ; prev_ball_x, prev_ball_y
    
.check_x:
    xor dx, dx
    mov ax, [ball_x]
    mov bx, [ball_y]
    xor cx, cx
    mov cl, [ball_r]
    add ax, cx
    cmp ax, [left_bound]
    jle .check_y
    sub ax, cx
    sub ax, cx
    cmp ax, [right_bound]
    jge .check_y
    jmp .check_x_top

.check_x_top:
    sub bx, cx
    cmp bx, [top_bound]
    jl .check_x_bot
    cmp bx, [bottom_bound]
    jge .check_y
    jmp .reverse_x_speed

.check_x_bot:
    add bx, cx
    add bx, cx
    cmp bx, [top_bound]
    jle .check_y
    jmp .reverse_x_speed

.reverse_x_speed:
    mov ax, [prev_ball_x]
    cmp ax, [left_bound]
    jle .left_collision
    cmp ax, [right_bound]
    jge .right_collision
    jmp .check_y
.left_collision:
    mov ah, [ball_x_speed]
    mov al, 100
    sub al, ah
    add al, 100
    jmp .save_x_speed
.right_collision:
    mov ah, [ball_x_speed]
    mov al, 100
    sub ah, al
    mov al, 100
    sub al, ah
    jmp .save_x_speed
.save_x_speed:
    mov [ball_x_speed], al
    mov dh, 1
    jmp .check_y

.check_y:
    mov ax, [ball_x]
    mov bx, [ball_y]
    xor cx, cx
    mov cl, [ball_r]
    add bx, cx
    cmp bx, [top_bound]
    jle .adjust_x_collision
    sub bx, cx
    sub bx, cx
    cmp bx, [bottom_bound]
    jge .adjust_x_collision
    jmp .check_y_top

.check_y_top:
    sub ax, cx
    cmp ax, [left_bound]
    jl .check_y_bot
    cmp ax, [right_bound]
    jge .adjust_x_collision
    jmp .reverse_y_speed

.check_y_bot:
    add ax, cx
    add ax, cx
    cmp ax, [left_bound]
    jle .adjust_x_collision
    jmp .reverse_y_speed
    
.reverse_y_speed:
    mov ax, [prev_ball_y]
    cmp ax, [top_bound]
    jle .top_collision
    cmp ax, [bottom_bound]
    jge .bottom_collision
    jmp .adjust_x_collision
.top_collision:
    mov ah, [ball_y_speed]
    mov al, 100
    sub al, ah
    add al, 100
    jmp .save_y_speed
.bottom_collision:
    mov ah, [ball_y_speed]
    mov al, 100
    sub ah, al
    mov al, 100
    sub al, ah
    jmp .save_y_speed
.save_y_speed:
    mov [ball_y_speed], al
    mov dl, 1
    jmp .adjust_x_collision

.adjust_x_collision:
    cmp dh, 1
    jne .adjust_y_collision
    call UPDATE_BALL_X_POSITION
    call UPDATE_BALL_X_POSITION
    jmp .adjust_y_collision

.adjust_y_collision:
    cmp dl, 1
    jne .end
    call UPDATE_BALL_Y_POSITION
    call UPDATE_BALL_Y_POSITION
    jmp .end

.end:
    ret


ERASE_BALL:
    mov ax, [prev_ball_x]
    mov bx, [prev_ball_y]
    mov dh, [ball_r]
    mov dl, 0
    call DRAW_BALL
    ret


REDRAW_BALL:
    mov ax, [ball_x]
    mov bx, [ball_y]
    mov dh, [ball_r]
    mov dl, [ball_color]
    call DRAW_BALL
    ret


UPDATE_BALL_X_POSITION:
    push dx
    xor dx, dx
    mov dl, [ball_x_speed]
    mov ax, [ball_x]
    add ax, dx
    cmp ax, 100
    jle .out_of_bounds
    sub ax, 100
    jmp .end
.out_of_bounds:
    mov ax, 0
.end:
    mov [ball_x], ax
    pop dx
    ret


UPDATE_BALL_Y_POSITION:
    push dx
    xor dx, dx
    mov dl, [ball_y_speed]
    mov ax, [ball_y]
    add ax, dx
    cmp ax, 100
    jle .out_of_bounds
    sub ax, 100
    jmp .end
.out_of_bounds:
    mov ax, 0
.end:
    mov [ball_y], ax
    pop dx
    ret


UPDATE_BALL_POSITION:
    mov ax, [ball_x]
    mov [prev_ball_x], ax
    call UPDATE_BALL_X_POSITION
    mov ax, [ball_y]
    mov [prev_ball_y], ax
    call UPDATE_BALL_Y_POSITION
    ret


CHECK_WALL_COLLISIONS:
.left:
    mov word [left_bound], 0
    mov word [right_bound], 1
    mov word [top_bound], 0
    mov word [bottom_bound], 199
    call CHECK_BALL_COLLISION
    cmp dx, 0
    je .right
    call SOUND_BOUNCE

.right:
    mov word [left_bound], 318
    mov word [right_bound], 319
    mov word [top_bound], 0
    mov word [bottom_bound], 199
    call CHECK_BALL_COLLISION
    cmp dx, 0
    je .top
    call SOUND_BOUNCE

.top:
    mov word [left_bound], 0
    mov word [right_bound], 319
    mov word [top_bound], 0
    mov word [bottom_bound], 1
    call CHECK_BALL_COLLISION
    cmp dx, 0
    je .bottom
    call SOUND_BOUNCE

.bottom:
    mov word [left_bound], 0
    mov word [right_bound], 319
    mov word [top_bound], 198
    mov word [bottom_bound], 199
    call CHECK_BALL_COLLISION
    cmp dx, 0
    je .end
    call SOUND_BOUNCE
    
.end:
    ret


CHECK_PADDLE_COLLISION:
    mov ax, [paddle_x]
    mov bx, [paddle_y]
    xor cx, cx
    mov cl, [paddle_half_w]
    sub ax, cx
    mov [left_bound], ax
    add ax, cx
    add ax, cx
    mov [right_bound], ax
    xor dx, dx
    mov dl, [paddle_half_h]
    sub bx, dx
    mov [top_bound], bx
    add bx, dx
    add bx, dx
    mov [bottom_bound], bx

.check_x:
    xor dx, dx
    mov ax, [ball_x]
    mov bx, [ball_y]
    xor cx, cx
    mov cl, [ball_r]
    add ax, cx
    cmp ax, [left_bound]
    jle .check_y
    sub ax, cx
    sub ax, cx
    cmp ax, [right_bound]
    jge .check_y
    jmp .check_x_top

.check_x_top:
    sub bx, cx
    cmp bx, [top_bound]
    jl .check_x_bot
    cmp bx, [bottom_bound]
    jge .check_y
    jmp .reverse_x_speed

.check_x_bot:
    add bx, cx
    add bx, cx
    cmp bx, [top_bound]
    jle .check_y
    jmp .reverse_x_speed

.reverse_x_speed:
    mov ax, [prev_ball_x]
    cmp ax, [left_bound]
    jle .left_collision
    cmp ax, [right_bound]
    jge .right_collision
    jmp .check_y
.left_collision:
    mov ah, [ball_x_speed]
    mov al, 100
    sub al, ah
    add al, 100
    jmp .save_x_speed
.right_collision:
    mov ah, [ball_x_speed]
    mov al, 100
    sub ah, al
    mov al, 100
    sub al, ah
    jmp .save_x_speed
.save_x_speed:
    mov [ball_x_speed], al
    mov dh, 1
    jmp .check_y

.check_y:
    mov ax, [ball_x]
    mov bx, [ball_y]
    xor cx, cx
    mov cl, [ball_r]
    add bx, cx
    cmp bx, [top_bound]
    jle .adjust_x_collision
    sub bx, cx
    sub bx, cx
    cmp bx, [bottom_bound]
    jge .adjust_x_collision
    jmp .check_y_top

.check_y_top:
    sub ax, cx
    cmp ax, [left_bound]
    jl .check_y_bot
    cmp ax, [right_bound]
    jge .adjust_x_collision
    jmp .reverse_y_speed

.check_y_bot:
    add ax, cx
    add ax, cx
    cmp ax, [left_bound]
    jle .adjust_x_collision
    jmp .reverse_y_speed
    
.reverse_y_speed:
    mov ax, [prev_ball_y]
    cmp ax, [top_bound]
    jle .top_collision
    cmp ax, [bottom_bound]
    jge .bottom_collision
    jmp .adjust_x_collision
.top_collision:
    mov ax, [ball_x]
    mov bx, [paddle_x]
    cmp ax, bx
    jl .steer_left
    jg .steer_right
    jmp .steer_center
.steer_center:
    mov ah, 100
    mov [ball_x_speed], ah
    mov ah, 103
    mov [ball_y_speed], ah
    jmp .top_collision_continue
.steer_right:
    sub ax, bx
    mov bh, 6
    div bh
    cmp al, 1
    jge .increase_rspeed
.decrease_rspeed:
    mov ah, 101
    mov [ball_x_speed], ah
    mov ah, 103
    mov [ball_y_speed], ah
    jmp .top_collision_continue
.increase_rspeed:
    dec al
    mov ah, 102
    add ah, al
    mov [ball_x_speed], ah
    mov ah, 102
    sub ah, al
    mov [ball_y_speed], ah
    jmp .top_collision_continue
.steer_left:
    mov ax, bx
    mov bx, [ball_x]
    sub ax, bx
    mov bh, 6
    div bh
    cmp al, 1
    jge .increase_lspeed
.decrease_lspeed:
    mov ah, 99
    mov [ball_x_speed], ah
    mov ah, 103
    mov [ball_y_speed], ah
    jmp .top_collision_continue
.increase_lspeed:
    dec al
    mov ah, 98
    sub ah, al
    mov [ball_x_speed], ah
    mov ah, 102
    sub ah, al
    mov [ball_y_speed], ah
    jmp .top_collision_continue
.top_collision_continue:
    mov ah, [ball_y_speed]
    mov al, 100
    sub al, ah
    add al, 100
    jmp .save_y_speed
.bottom_collision:
    mov ah, [ball_y_speed]
    mov al, 100
    sub ah, al
    mov al, 100
    sub al, ah
    jmp .save_y_speed
.save_y_speed:
    mov [ball_y_speed], al
    mov dl, 1
    jmp .adjust_x_collision

.adjust_x_collision:
    cmp dh, 1
    jne .adjust_y_collision
    call UPDATE_BALL_X_POSITION
    call UPDATE_BALL_X_POSITION
    call SOUND_BOUNCE
    jmp .adjust_y_collision

.adjust_y_collision:
    cmp dl, 1
    jne .end
    call UPDATE_BALL_Y_POSITION
    call UPDATE_BALL_Y_POSITION
    call SOUND_BOUNCE
    jmp .end

.end:
    ret

    
CHECK_LEVEL_COLLISION:
    mov ax, [ball_x]
    mov bx, [ball_y]
    xor dx, dx
    mov cx, 29
    div cx
    mov si, ax
    mov ax, bx
    xor dx, dx
    mov cx, 9
    div cx
    mov bx, ax
    mov ax, si

.check_leftmost:
    cmp ax, 0
    jle .leftmost
    mov cx, ax
    dec cx
    jmp .check_topmost
.leftmost:
    mov cx, 0

.check_topmost:
    cmp bx, 0
    jle .topmost
    mov dx, bx
    dec dx
    jmp .check_rightmost
.topmost:
    mov dx, 0

.check_rightmost:
    cmp ax, 10
    jge .rightmost
    mov si, ax
    inc si
    jmp .check_bottommost
.rightmost:
    mov si, 10

.check_bottommost:
    cmp bx, 21
    jge .bottommost
    mov di, bx
    inc di
    jmp .check_neighbors
.bottommost:
    mov di, 21

.check_neighbors:
    mov ax, si
    mov bx, di
    mov si, current_level
    mov di, cx

.collision_check_loop:
    pusha
    push dx
    mov ax, dx
    xor dx, dx
    mov bx, 11
    mul bx
    add ax, cx
    mov bx, ax
    pop dx
    mov [block_x], cx
    mov [block_y], dx
    cmp byte [si + bx], 1
    jl .empty
    push dx
    mov ax, cx
    mov bx, 29
    xor dx, dx
    mul bx
    mov word [left_bound], ax
    add ax, 29
    mov word [right_bound], ax
    pop dx
    mov ax, dx
    push dx
    mov bx, 9
    xor dx, dx
    mul bx
    mov word [top_bound], ax
    add ax, 9
    mov word [bottom_bound], ax
    call CHECK_BALL_COLLISION
    cmp dx, 0
    pop dx
    jne .collided
    jmp .next_block

.empty:
    jmp .next_block

.next_block:
    popa
    inc cx
    cmp cx, ax
    jle .collision_check_loop
    inc dx
    cmp dx, bx
    jg .end
    mov cx, di
    jmp .collision_check_loop

.collided:
    mov cx, [block_x]
    mov dx, [block_y]
    mov ax, dx
    xor dx, dx
    mov bx, 11
    mul bx
    add ax, cx
    mov bx, ax
    cmp byte [si + bx], 100
    jne .update_level
    jmp .lose_life

.lose_life:
    mov al, [lives_left]
    dec al
    mov [lives_left], al
    call SOUND_LOSE_LIFE
    cmp al, 0
    jg .reset_level

    pusha
    mov ax, 1
    mov bx, 190
    mov cx, 18
    mov dh, 9
    mov dl, 0
    call DRAW_RECTANGLE
    popa

.wait_keypress:
    cmp byte [any_key_state], 1
    jne .wait_keypress
    
    mov byte [lives_left], 3
    mov byte [current_score], 0
    call REBUILD_LEVEL

.reset_level:
    jmp MAIN

.update_level:
    mov byte [si + bx], 0
    mov byte [current_color + bx], 0
    mov ax, [block_y]
    mov cx, 9
    xor dx, dx
    mul cx
    add ax, 1
    mov bx, ax
    mov ax, [block_x]
    mov cx, 29
    xor dx, dx
    mul cx
    add ax, 1
    mov cx, 28
    mov dh, 8
    mov dl, 0
    call DRAW_RECTANGLE
    call SOUND_BLOCK_BREAK
    mov al, [current_score]
    inc al
    mov [current_score], al
    mov al, [blocks_left]
    dec al
    mov [blocks_left], al
    cmp al, 0
    jg .redraw_score

.next_level:
    call SOUND_NEXT_LEVEL
    call REBUILD_LEVEL
    jmp MAIN

.redraw_score:
    pusha
    mov ax, 301
    mov bx, 190
    mov cx, 18
    mov dh, 9
    mov dl, 0
    call DRAW_RECTANGLE
    popa
    pusha
    mov al, [current_score]
    call DRAW_SCORE
    popa
    popa
    jmp .end

.end:
    ret


REBUILD_LEVEL:
    mov bx, 0
    mov cx, 242
    mov si, level_bitmap
    mov di, current_level

.reset_blocks:
    mov ax, [si + bx]
    mov [di + bx], ax
    inc bx
    cmp bx, cx
    jl .reset_blocks

    mov bx, 0
    mov cx, 77
    mov si, block_color_bitmap
    mov di, current_color

.reset_color:
    mov ax, [si + bx]
    mov [di + bx], ax
    inc bx
    cmp bx, cx
    jl .reset_color

    mov byte [blocks_left], 45
    ret


SET_SPEAKER_FREQ:
    push cx
    push dx
    push ax
    
    ; Setup speaker access
    mov al, 0xB6
    out 0x43, al
    
    ; Send low byte of divisor
    pop ax
    out 0x42, al
    
    ; Send high byte of divisor
    mov al, ah
    out 0x42, al

    pop dx
    pop cx
    ret


SPEAKER_ON:
    push ax
    push dx
    
    ; Set 0 and 1 bit from PCR
    in  al, 0x61
    or  al, 0x03
    out 0x61, al
    
    pop dx
    pop ax
    ret


SPEAKER_OFF:
    push ax
    push dx
    
    ; Clear 0 and 1 bit from PCR
    in  al, 0x61
    and al, 0xFC
    out 0x61, al
    
    pop dx
    pop ax
    ret


SOUND_BOUNCE:
    push ax
    push cx
    
    ; Set frequency
    mov ax, 785
    call SET_SPEAKER_FREQ
    
    ; Turn speaker on
    call SPEAKER_ON
    
    ; Add delay
    mov cx, 10

.bounce_delay_loop:
    push ax
    mov ax, 994     

.inner_bounce_delay:
    dec ax
    jnz .inner_bounce_delay
    pop ax
    loop .bounce_delay_loop
    
    ; Turn speaker off
    call SPEAKER_OFF
    
    pop cx
    pop ax
    ret


SOUND_BLOCK_BREAK:
    push ax
    push cx
    push bx
    
    ; Set frequency and duration
    mov bx, 994
    mov cx, 20
    
    ; Turn speaker on
    call SPEAKER_ON
    
.sweep_loop:
    push cx
    
    ; Set current frequency pitch
    mov ax, bx
    call SET_SPEAKER_FREQ
    
    ; Add delay
    push ax
    mov ax, 20

.inner_sweep_delay:
    dec ax
    jnz .inner_sweep_delay
    pop ax
    
    ; Change pitch for next cycle
    add bx, 25
    
    pop cx
    loop .sweep_loop

    ; Turn speaker off
    call SPEAKER_OFF
    
    pop bx
    pop cx
    pop ax
    ret


SOUND_LOSE_LIFE:
    push ax
    push cx
    
    ; Set first frequency
    mov ax, 1356
    call SET_SPEAKER_FREQ
    
    ; Turn speaker on
    call SPEAKER_ON
    
    ; Add delay
    mov cx, 20

.bounce_delay_loop_first:
    push ax
    mov ax, 994

.inner_bounce_delay_first:
    dec ax
    jnz .inner_bounce_delay_first
    pop ax
    loop .bounce_delay_loop_first
    
    ; Turn speaker off
    call SPEAKER_OFF

    ; Set second frequency
    mov ax, 3977
    call SET_SPEAKER_FREQ
    
    ; Turn speaker on
    call SPEAKER_ON
    
    ; Add delay
    mov cx, 50

.bounce_delay_loop_last:
    push ax
    mov ax, 994

.inner_bounce_delay_last:
    dec ax
    jnz .inner_bounce_delay_last
    pop ax
    loop .bounce_delay_loop_last
    
    ; Turn speaker off
    call SPEAKER_OFF

    pop cx
    pop ax
    ret


SOUND_NEXT_LEVEL:
    push ax
    push cx
    
    ; Set first frequency
    mov ax, 1988
    call SET_SPEAKER_FREQ
    
    ; Turn speaker off
    call SPEAKER_ON
    
    ; Add delay
    mov cx, 30

.bounce_delay_loop_first:
    push ax
    mov ax, 994

.inner_bounce_delay_first:
    dec ax
    jnz .inner_bounce_delay_first
    pop ax
    loop .bounce_delay_loop_first
    
    ; Turn speaker off
    call SPEAKER_OFF

    ; Set second frequency
    mov ax, 1193
    call SET_SPEAKER_FREQ
    
    ; Turn speaker on
    call SPEAKER_ON
    
    ; Add delay
    mov cx, 20

.bounce_delay_loop_last:
    push ax
    mov ax, 994         

.inner_bounce_delay_last:
    dec ax
    jnz .inner_bounce_delay_last
    pop ax
    loop .bounce_delay_loop_last
    
    ; Turn speaker off
    call SPEAKER_OFF

    pop cx
    pop ax
    ret