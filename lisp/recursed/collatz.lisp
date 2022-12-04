#!/usr/bin/sbcl --script

(defun collatz_sequence (num length)
(cond 
    ((= num 1) (return-from collatz_sequence length))
    (t 
    (cond ((= (mod num 2) 0) (setf num (/ num 2)))
        ((/= (mod num 2) 0) (setf num (+ 1 (* num 3)))))
    (setf length (+ length 1))
    (collatz_sequence num length))))

(defun length_sort (nums lengths)
    (loop for i from 0 to (1- (length lengths))
        do (loop for j from 0 to (1- (length lengths))
            do (cond ((and (/= (aref nums i) (aref nums j)) (= (aref lengths i) (aref lengths j)))
                (setf (aref lengths j) 0)))))

    (loop for i from (1- (length lengths)) downto 0 do
        (loop for j from 0 to (1- i)
            when (>= (aref lengths (1+ j)) (aref lengths j))
               do (rotatef (aref lengths (1+ j)) (aref lengths j))
               (rotatef (aref nums (1+ j)) (aref nums j)))))

(defun int_sort (nums_final lengths)
(loop for i from (1- (length nums_final)) downto 0 do
        (loop for j from 0 to (1- i)
            when (>= (aref nums_final (1+ j)) (aref nums_final j))
               do (rotatef (aref nums_final (1+ j)) (aref nums_final j))
               (rotatef (aref lengths (1+ j)) (aref lengths j)))))

(defvar num1 (parse-integer(nth 1 sb-ext:*posix-argv*)))
(defvar num2 (parse-integer (nth 2 sb-ext:*posix-argv*)))
(when (> num1 num2)
    (rotatef num1 num2))
(defvar nums (make-array (list (1+ (- num2 num1)))))
(defvar lengths (make-array (list (length nums))))
(defvar nums_final (make-array '(10)))
(defvar l 0)



(progn 
(loop for i from 0 to (1- (length nums))
    do (setf (aref nums i) (+ i num1)) 
    (setf (aref lengths i) (collatz_sequence (aref nums i) l))
    )
(length_sort nums lengths)
(princ "Sorted based on sequence length:")
(terpri)
(loop for i from 0 to 9
    do (format t "~D    ~D~%" (aref nums i) (aref lengths i))
    (setf (aref nums_final i) (aref nums i)))
(int_sort nums_final lengths)
(princ "Sorted based on integer size:")
(terpri)
(loop for i from 0 to 9
    do (format t "~D    ~D~%" (aref nums_final i) (aref lengths i))
    )
)


