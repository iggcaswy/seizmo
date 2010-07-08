% Seismology Toolbox - misc
% Version 0.6.0-r150 Everest 8-July-2010
%
% Miscellaneous Support functions
%BUTTORD2            - Butterworth filter order selection. (Honors passband corners)
%CIRCLE              - Returns points on a circle in cartesian space
%DDENDROGRAM         - Generate dendrogram plot (with some extra color options)
%EXPANDSCALARS       - Expands scalars to match size of array inputs
%FILTER_BANK         - Makes a set of narrow-band bandpass filters
%FISHER              - Converts correlation coefficients to the Z statistic
%GAUSSIANTF          - Returns a gaussian time function
%GETAPPLICATION      - Returns application running this script and its version
%GETSUBFIELD         - Get substructure field contents
%GETWORDS            - Returns a cell array of words from a string
%IFISHER             - Converts Z statistics to correlation coefficients
%IIRDESIGN           - Designs an iir filter with the given constraints
%INVERTCOLOR         - Inverts colors given as rgb triplet or as short/long names
%INTERPDC1           - 1D interpolation (table lookup) with discontinuity support
%ISEQUALSIZEORSCALAR - True if all input arrays are equal size or scalar
%ISORTHOGONAL        - TRUE if orientations are orthogonal
%ISPARALLEL          - TRUE if orientations are parallel
%JOINWORDS           - Combines a cellstr into a space-separated string
%LTI2SUB             - Square matrix lower triangle linear indices to subscripts
%MATCHSORT           - Replicates a sort operation using the returned permutation indices
%MCXC                - Multi-channel cross correlation with built-in peak picker
%NAME2RGB            - Converts short/long color names to RGB triplets
%NANVARIANCE         - Return variance excluding NaNs
%NATIVEBYTEORDER     - Returns native endianness of present platform
%NDSQUAREFORM        - Reshapes between an n-d distance matrix and "vector"
%NEXTPOW2N           - Returns the next higher power of 2 for all array elements
%ONEFILELIST         - Compiles multiple filelists into one
%PPDCVAL             - Evaluate piecewise polynomial (w/ discontinuity support)
%PRINT_TIME_LEFT     - Ascii progress bar
%READCSV             - Read in .csv formatted file as a structure
%READTXT             - Reads in a text file as a single string
%RRAT                - Rational approximation. (UNBUGGED VERSION)
%SLIDINGAVG          - Returns sliding-window average of data
%SNR2MAXPHASEERROR   - Returns maximum narrow-band phase error based on SNR 
%SORT2LI             - Transforms permutation indices from sort to linear indices
%STRNLEN             - Pad/truncate char/cellstr array to n character columns
%SUB2LTI             - Square matrix lower triangle linear indices from subscripts
%SUB2UTI             - Square matrix upper triangle linear indices from subscripts
%SUBMAT              - Returns a submatrix reduced along indicated dimensions
%SUBMAT_EVAL         - Returns a submatrix using eval
%SWAP                - Swap values
%TAPERFUN            - Returns a taper as specified
%TRIANGLETF          - Returns a triangle time function
%UNSORT              - Undoes a sort operation using the returned sort indices
%UNIXCOMPRESSAVI     - Compress an AVI file in Unix with "MEncoder"
%UTI2SUB             - Square matrix upper triangle linear indices to subscripts
%VECNORM             - Returns vector norms
%WRITECSV            - Write out .csv formatted file from a structure
%XDIR                - Cross-app compatible directory listing with recursion

