PrintRealTimeClock::
	push af
	push bc
	push de
	push hl
	hlcoord 0, 13
	lb bc, 3, 9
	call TextBoxBorder
	call PrepareClockStrings
	hlcoord 1, 14
	ld de, wClockBuffer
	call PlaceString
	hlcoord 1, 15
	ld de, wClockBuffer + 20
	call PlaceString
	hlcoord 1, 16
	ld de, wClockBuffer + 40
	call PlaceString
	pop hl
	pop de
	pop bc
	pop af
	ret

PrepareClockStrings::
	ld hl, wClockBuffer ; first line
	ld a, [wRTCDayOfWeek] ; day of week
	ld hl, ClockDayNames
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc ; 2 bytes
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wClockBuffer
.copy
	ld a, [hli]
	ld [de], a
	inc de
	cp '@'
	jr nz, .copy
	ld hl, wClockBuffer + 20 ; second line
	ld a, [wRTCDay] ; day of month
	call PrintDate
	ld a, '-'
	ld [hli], a
	ld a, [wRTCMonth] ; month
	call PrintDate	
	ld a, '-'
	ld [hli], a
	ld a, [wRTCYear] ; year
	call PrintDate
	ld a, '@'
	ld [hli], a
	ld hl, wClockBuffer + 40 ; third line
	ld a, [wRTCHours] ; hours
	call PrintDate
	ld a, ':'
	ld [hli], a
	ld a, [wRTCMinutes] ; minutes
	call PrintDate
	ld a, ':'
	ld [hli], a
	ld a, [wRTCSeconds] ; seconds
	call PrintDate
	ld a, '@'
	ld [hl], a
	ret

ClockDayNames:
	dw .Sun, .Mon, .Tue, .Wed, .Thu, .Fri, .Sat

.Sun db "SUNDAY@"
.Mon db "MONDAY@"
.Tue db "TUESDAY@"
.Wed db "WEDNESDAY@"
.Thu db "THURSDAY@"
.Fri db "FRIDAY@"
.Sat db "SATURDAY@"

PrintDate:
	ld b, 0

.loop
	cp 10
	jr c, .done
	sub 10
	inc b
	jr .loop

.done
	push af
	ld a, b
	add '0'
	ld [hli], a
	pop af
	add '0'
	ld [hli], a
	ret
