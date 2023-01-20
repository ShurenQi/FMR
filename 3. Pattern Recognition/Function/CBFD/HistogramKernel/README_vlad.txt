Modifications :

The original package of LIBSVM 3.0 was little bit modified to include
intersection kernel. This kernel is particularly useful for histograms and
has been shown to be efficient in computer vision tasks.

Original code of LIBSVM 3.0 was taken from :
http://www.csie.ntu.edu.tw/~cjlin/libsvm/

The code for intersection kernel was ported to LIBSVM from :
http://www.cs.berkeley.edu/~smaji/projects/fiksvm/

Actually, anybody capable reading and understanding the code, can introduce
his own kernel (provided it is positive definite etc - another story).

The code was just tiny bit retouched : C++ style comments were changed to C
style since my mex compiler complained on them.

Because of diversity of platforms, systems and compilers, you will need to compile the code by yourself.

Finally, anybody wishing to recompile or introduce some changes, is always
free to look in folder 'source'.

Vlad
