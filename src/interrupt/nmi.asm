.segment "ZEROPAGE"
    nmi_ready: .res 1
    palette_init: .res 1
    scroll_x: .res 1
    tile_ID: .res 1
    screen_pointer: .res 1
    sprite_logger: .res 8
    player_x: .res 1
    player_y: .res 1
    x_mem: .res 1
    y_mem: .res 1

.segment "CODE"

nmi:
    pha             ; make sure we don't clobber the A register

    lda nmi_ready   ; check the nmi_ready flag
    bne nmi_go      ; if nmi_ready set to 1 we can execute the nmi code
        pla
        rti
    nmi_go:

    ; set the player metasprite with a proc
    ; call the oam dma with a proc
    jsr oam_dma

    jsr update_player_sprite

    lda PPU_STATUS ; $2002

    set PPU_SCROLL, scroll_x
    set PPU_SCROLL, #0

    set nmi_ready, #0

    pla
    rti
