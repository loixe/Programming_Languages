#lang racket
; Question 1
(define (map fun l1)
  (if (empty? l1)
      '()
      (cons
       (fun (car l1))
       (map fun (cdr l1)))))

(define (arg-max fun li)
  (if (empty? li)
      -1
      (if (empty? (cdr li))
          (car li)
          (if (< (car (map fun li)) (cadr (map fun li)))
              (arg-max fun (cdr li))
              (arg-max fun
                       (cons
                        (car li) (cddr li)))))))
(define (square a) (* a a))
(arg-max square '(5 4 3 2 1))
(define (invert a) (/ 1000 a))
(arg-max invert '(5 4 3 2 1))
(arg-max (lambda (x) (- 0 (square (- x 3)))) '(5 4 3 2 1))

; Question 2
(define (zip . args)
  args)
(zip '(1 2 3) '(2 3 5))
(zip '(1 2 3) '(2 3 5) '(5 6 7))

; Question 3
(define (unzip ls n)
  (if (empty? ls)
      empty
      (if (= 0 n)
          (car ls)
          (unzip (cdr ls) (- n 1)))))
(unzip '((1 2 3) (5 6 7) (5 9 2)) 1)
(unzip '((1 2 3) (5 6 7) (5 9 2 )) 0)

; Question 4
(define (cancelnum n l2)
  (if (empty? n)
      l2
      (if (empty? l2)
        '()
        (if (= n (car l2))
            (cancelnum n (cdr l2))
            (cons
             (car l2) (cancelnum n (cdr l2)))))))
(define (cancel l1 l2)
  (if (empty? l2)
      l1
      (if (empty? l1)
          '()
          (cancel (cancelnum (car l2) l1) (cdr l2)))))
(define (cancellist l1 l2)
  (list (cancel l1 l2) (cancel l2 l1)))
(cancellist '() '())
(cancellist '(1 3) '(2 4))
(cancellist '(1 2) '(2 4))
(cancellist '(1 2 3) '(1 2 2 3 4))

; Question 5
(define (sortedmerge l1 l2)
  (if (empty? l2)
      l1
      (if (empty? l1)
          l2
          (if (< (car l1) (car l2))
              (cons
               (car l1)
               (sortedmerge (cdr l1) l2))
              (cons
               (car l2)
               (sortedmerge l1 (cdr l2)))))))
(sortedmerge '(1 2 3) '(4 5 6))
(sortedmerge '(1 3 5) '(2 4 6))
(sortedmerge '(1 3 5) '())

; Question 6
(define (interleave l1 l2)
  (if (empty? l2)
      l1
      (if (empty? l1)
          l2
          (cons
           (car l1)
           (interleave l2 (cdr l1))))))
(interleave '(1 2 3) '(a b c))
(interleave '(1 2 3) '(a b c d e f))
(interleave '(1 2 3 4 5 6) '(a b c))

; Question 7
; We define map before in question 1
(define (map2 j l p f)
  (if (empty? j)
      '()
      (if (equal? #t (car (map p j)))
             (cons
              (car (map f (list (car l))))
              (map2 (cdr j) (cdr l) p f))
             (cons
              (car l)
              (map2 (cdr j) (cdr l) p f)))))

(define inc
  (lambda (x) (+ x 1)))

(map2 '(1 2 3 4) '(2 3 4 5) (lambda (x) (> x 2)) inc)

(define (filter f l)
  (if (empty? l)
      empty
      (if (equal? #t (car (map f l)))
          (cons
           (car l)
           (filter f (cdr l)))
          (filter f (cdr l)))))
(filter (lambda (n) (> n 10)) '(10 15 20))
(map (lambda (n) (> n 10)) '(5 10 15 20))

; Question 8
; We define inc already in question 7
(define ((compose f1 f2) n)
  (f2 (f1 n)))
(compose inc inc)
((compose inc inc) 5)


(let* ((x 2) (y 3))
  (let* ((x 7)
        (z (+ x y)))
    (* z x)))


(define (sum L)
  (if (empty? L)
      0
      (+ (car L) (sum (cdr L)))))
(define (average L)
  (/ (sum L) (length L)))
(average '(2 4 6 8)) 

(define ((bar n) l)
  (if (empty? l)
      empty
      (cons
       (+ n (car l)) ((bar n) (cdr l)))))
((bar 3) '(1 2 3 4))

(define (reduce f L)
  (if (empty? (cdr L))
      (car L)
      (f (car L) (reduce f (cdr L)))))
(reduce + '(1 2 3 4))
(reduce max '(1 2 3 4))

;(reduce (lambda (x y) (if (> x y) x y)) L)
(reduce (lambda (x y) (if (> x y) x y)) '(1 2 3 4))

(define (list-and lst)
  (if (empty? lst)
      #t
      (if (equal? #f (car lst))
          #f
          (list-and (cdr lst)))))
(list-and '(1 (even? 2)))
(define lst '(#t lst #f (even? 2)))
(list-and lst)
      
