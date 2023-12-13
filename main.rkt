#lang racket/gui

; =========================================== CONSTRAINTS ===========================================
(define MAX_WIDTH 800)
(define MAX_HEIGTH 800)

; =========================================== HEADER ===========================================
; Make a frame by instantiating the frame% class
(define frame (new frame%
                   [label "Recursive calls view for %PROCEDURE%"]
                   [width MAX_WIDTH]
                   [height MAX_HEIGTH]))

#| ; Make a static text message in the frame
   (define msg (new message% [parent frame]
                    [label "No events so far..."]))
    
   ; Make a button in the frame
   (new button% [parent frame]
        [label "Click Me"]
        ; Callback procedure for a button click:
        [callback (lambda (button event)
                 (send msg set-label "Button click"))]) |#
 
; Show the frame by calling its show method
(send frame show #t)

; =========================================== CANVAS ===========================================
; Derive a new canvas (a drawing window) class to handle events
#| (define my-canvas%
     (class canvas% ; The base class is canvas%
       ; Define overriding method to handle mouse events
       (define/override (on-event event)
         (send msg set-label "Canvas mouse"))
       ; Define overriding method to handle keyboard events
       (define/override (on-char event)
         (send msg set-label "Canvas keyboard"))
       ; Call the superclass init, passing on all init args
    (super-new)))
|#
 
; Make a canvas that handles events in the frame
(new canvas% [parent frame]
     [paint-callback
      (lambda (canvas dc)
        (send dc set-scale 3 3)
        (send dc set-text-foreground "blue")
        
        (define-values (w h d a) (send dc get-text-extent "Hello, World!"))
        (send dc draw-text "Hello, World!" (/ (- 100 w) 2) (/ (- 30 h) 2))


        ;; DRAW A STATIC BINARY TREE
        (draw-binary-tree dc 90 40)
        
        )])

; =========================================== FOOTER ===========================================
#|
(define panel (new horizontal-panel% [parent frame][alignment '(center center)]))
   (new button% [parent panel]
        [label "Left"]
        [callback (lambda (button event)
                    (send msg set-label "Left click"))])
   (new button% [parent panel]
        [label "Right"]
        [callback (lambda (button event)
                 (send msg set-label "Right click"))])
|#




; =========================================== DRAW ===========================================
(define no-pen (new pen% [style 'transparent]))
(define no-brush (new brush% [style 'transparent]))
(define blue-pen (new pen% [color "blue"]))

; =========================================== DRAW CIRCLE ====================================
(define (draw-circle dc x y)
  (send dc set-smoothing 'aligned)
 
  (send dc set-pen blue-pen)
  (send dc set-brush no-brush)
  (send dc draw-ellipse x y 20 20))

; =========================================== DRAW CIRCLE ====================================
(define (draw-binary-tree dc x y)
  ; parent
  (draw-circle dc x y)  
  )



; =========================================== CONNECT TWO CIRCLES ====================================
(define (connect dc c1x c1y c2x c2y)
  (send dc draw-line
        c1x c1y
        c2x c2y))



; =========================================== PRINT DRAWINGS ==================================
(define target (make-bitmap MAX_WIDTH MAX_HEIGTH))
(define dc (new bitmap-dc% [bitmap target]))