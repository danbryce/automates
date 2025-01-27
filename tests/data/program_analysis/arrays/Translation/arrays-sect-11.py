from automates.program_analysis.for2py.format import *
from automates.program_analysis.for2py.arrays import *

def main():
    A = Array([(1,4),(1,6)])
    B = Array([(1,2)])

    B.set_elems(array_subscripts(B), [1,4])      # B = (/1,4/)

    for i in range(1,4+1):
        for j in range(1,6+1):
            A.set_((i,j), i*i+j*j)          # A(i,j) = i*i+j*j


    fmt_obj_10 = Format(['"BEFORE: "', '6(I5)'])
    fmt_obj_11 = Format(['""'])
    fmt_obj_12 = Format(['"AFTER:  "', '6(I5)'])

    for i in range(1,4+1):
        sys.stdout.write(fmt_obj_10.write_line([A.get_((i,1)), A.get_((i,2)), \
                                                A.get_((i,3)), A.get_((i,4)), \
                                                A.get_((i,5)), A.get_((i,6))]))
    sys.stdout.write(fmt_obj_11.write_line([]))

    A_subs = idx2subs([array_values(B), [1,3,4]])    # A(B, (/1,3,4/) )
    A.set_elems(A_subs, -1)

    for i in range(1,4+1):
        sys.stdout.write(fmt_obj_12.write_line([A.get_((i,1)), A.get_((i,2)), \
                                                A.get_((i,3)), A.get_((i,4)), \
                                                A.get_((i,5)), A.get_((i,6))]))



main()
