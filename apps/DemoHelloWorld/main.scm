#|
LambdaNative - a cross-platform Scheme framework
Copyright (c) 2009-2013, University of British Columbia
All rights reserved.

Redistribution and use in source and binary forms, with or
without modification, are permitted provided that the
following conditions are met:

* Redistributions of source code must retain the above
copyright notice, this list of conditions and the following
disclaimer.

* Redistributions in binary form must reproduce the above
copyright notice, this list of conditions and the following
disclaimer in the documentation and/or other materials
provided with the distribution.

* Neither the name of the University of British Columbia nor
the names of its contributors may be used to endorse or
promote products derived from this software without specific
prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
|#
;; helloworld example

(define ahooga #f)

(define gui #f)

(define timewheel #f)

(define (button-callback g w t x y)
  (let ((oldcolor (glgui-widget-get g w 'color)))
    (if ahooga (audiofile-play ahooga))
    (glgui-widget-set! g w 'color (if (= oldcolor White) Red White))
  )
)

(main
;; initialization
  (lambda (w h)
    (make-window 320 480)
    (glgui-orientation-set! GUI_PORTRAIT)
    (set! gui (make-glgui))
    (glgui-menubar gui 0 (- (glgui-height-get) 44) (glgui-width-get) 44)
    (glgui-menubar gui 0 0 (glgui-width-get) 44)
    (glgui-pixmap  gui 8 (- (glgui-height-get) 32) title.img)
    (let ((bw 150) (bh 50))
       (let ((bx (/ (- (glgui-width-get) bw) 2.))
             (by (/ (- (glgui-height-get) bh) 2.)))
          (glgui-button-string gui bx by bw bh "Me too!!!" ascii_18.fnt button-callback))
       (let ((bx (- (glgui-width-get) bw 10)) (by (+ 44 10)))
          (glgui-button-string gui bx by bw bh "And me!!" ascii_18.fnt button-callback))
       (let ((bx 10) (by (- (glgui-height-get) 44 10 bh)))
          (glgui-button-string gui bx by bw bh "Push me!" ascii_18.fnt button-callback))
    )
    (audiofile-init)
    (set! ahooga (audiofile-load "ahooga"))
  )
;; events
  (lambda (t x y) 
    (if (= t EVENT_KEYPRESS) (begin 
      (if (= x EVENT_KEYESCAPE) (terminate))))
    (glgui-event gui t x y))
;; termination
  (lambda () #t)
;; suspend
  (lambda () (glgui-suspend))
;; resume
  (lambda () (glgui-resume))
)

;; eof
