unit opencv_types;

interface
{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

type

  PCvArr = ^CvArr;
  CvArr = pointer;


  Cv32suf = packed record
    i: integer;
    u: Cardinal; // unsigned
    f: single;
  end;

  Cv64suf = packed record
    i: Int64;
    u: UInt64;
    f: double;
  end;


///****************************************************************************************\
//*                             Common macros and inline functions                         *
//\****************************************************************************************/
const
  CV_PI   = 3.1415926535897932384626433832795;
  CV_LOG2 = 0.69314718055994530941723212145818;




///****************************************************************************************\
//*                                  Image type (IplImage)                                 *
//\****************************************************************************************/



type
  IplROI =  packed record
      coi: integer;// /* 0 - no COI (all channels are selected), 1 - 0th channel is selected ...*/
      xOffset: integer;//;
      yOffset: integer;//;
      width: integer;//;
      height: integer;//;
  end;

  IplTileInfo = packed  record
  end;
  PIplTileInfo = ^IplTileInfo;

  _IplROI = IplROI;
  P_IplROI = ^_IplROI;


const
  IPL_DEPTH_SIGN = $80000000;

  IPL_DEPTH_1U    = 1;
  IPL_DEPTH_8U    = 8;
  IPL_DEPTH_16U   =16;
  IPL_DEPTH_32F   =32;

  IPL_DEPTH_8S = (IPL_DEPTH_SIGN OR 8);
  IPL_DEPTH_16S= (IPL_DEPTH_SIGN OR 16);
  IPL_DEPTH_32S= (IPL_DEPTH_SIGN OR 32);

  IPL_DATA_ORDER_PIXEL = 0;
  IPL_DATA_ORDER_PLANE = 1;

  IPL_ORIGIN_TL= 0;
  IPL_ORIGIN_BL= 1;

  IPL_ALIGN_4BYTES  = 4;
  IPL_ALIGN_8BYTES  = 8;
  IPL_ALIGN_16BYTES =16;
  IPL_ALIGN_32BYTES =32;

  IPL_ALIGN_DWORD =  IPL_ALIGN_4BYTES;
  IPL_ALIGN_QWORD =  IPL_ALIGN_8BYTES;

  IPL_BORDER_CONSTANT  = 0;
  IPL_BORDER_REPLICATE = 1;
  IPL_BORDER_REFLECT   = 2;
  IPL_BORDER_WRAP      = 3;

type
  PPIplImage = ^PIplImage;
  PIplImage = ^IplImage;

  IplImage =  packed record
     nSize: integer;               //  /* sizeof(IplImage) */
     ID: integer;                  //  /* version (=0)*/
     nChannels: integer;           //  /* Most of OpenCV functions support 1,2,3 or 4 channels */
     alphaChannel: integer;        //  /* Ignored by OpenCV */
     depth: integer;               //  /* Pixel depth in bits: IPL_DEPTH_8U, IPL_DEPTH_8S, IPL_DEPTH_16S,
                                   //   IPL_DEPTH_32S, IPL_DEPTH_32F and IPL_DEPTH_64F are supported.  */
     colorModel: array[0..3]of ansichar;// [4];     ///* Ignored by OpenCV */
     channelSeq: array[0..3]of ansichar;     ///* ditto */
     dataOrder: integer;           //   /* 0 - interleaved color channels, 1 - separate color channels.
                                   //  cvCreateImage can only create interleaved images */
     origin: integer;              //   /* 0 - top-left origin,
                                   //   1 - bottom-left origin (Windows bitmaps style).  */
     align: integer;               ///* Alignment of image rows (4 or 8).
                                   //   OpenCV ignores it and uses widthStep instead.    */
     width: integer;               //  /* Image width in pixels.                           */
     height: integer;              //  /* Image height in pixels.                          */
     roi: P_IplROI;                //  /* Image ROI. If NULL, the whole image is selected. */
     maskROI:PIplImage;            //  /* Must be NULL. */
     imageId: pointer;             //  /* "           " */
     tileInfo: PIplTileInfo;//  struct _IplTileInfo *tileInfo;  ///* "           " */
     imageSize: integer;         ///* Image data size in bytes
                            //   (==image->height*image->widthStep
                            //   in case of interleaved data)*/
    imageData: pointer;        ///* Pointer to aligned image data.         */
    widthStep: integer;         ///* Size of aligned image row in bytes.    */
    BorderMode: array[0..3] of integer;// [4];     ///* Ignored by OpenCV.                     */
    BorderConst: array[0..3]of integer;//[4];    ///* Ditto.                                 */
    imageDataOrigin: PansiChar;  ///* Pointer to very origin of image data
                            //   (not necessarily aligned) -
                            //   needed for correct deallocation */

  end;

  PIplConvKernel = ^IplConvKernel;
  IplConvKernel =  packed record
    nCols: integer;
    nRows: integer;
    anchorX: integer;
    anchorY: integer;
    values : Pinteger;
    nShiftR: integer;
  end;

  IplConvKernelFP =  packed record
    nCols: integer;
    nRows: integer;
    anchorX: integer;
    anchorY: integer;
    values : Psingle;
  end;


const
 IPL_IMAGE_HEADER =1;
 IPL_IMAGE_DATA   =2;
 IPL_IMAGE_ROI    =4;

///* extra border mode */
IPL_BORDER_REFLECT_101 = 4;

IPL_IMAGE_MAGIC_VAL = sizeof(IplImage);
CV_TYPE_NAME_IMAGE = 'opencv-image';

//#define CV_IS_IMAGE_HDR(img) \
//    ((img) != NULL && ((const IplImage*)(img))->nSize == sizeof(IplImage))
//
//#define CV_IS_IMAGE(img) \
//    (CV_IS_IMAGE_HDR(img) && ((IplImage*)img)->imageData != NULL)


///* for storing double-precision
//   floating point data in IplImage's */
IPL_DEPTH_64F = 64;

///* get reference to pixel at (col,row),
//   for multi-channel images (col) should be multiplied by number of channels */
//#define CV_IMAGE_ELEM( image, elemtype, row, col )       \
//    (((elemtype*)((image)->imageData + (image)->widthStep*(row)))[(col)])


 CV_CN_MAX     =64;
 CV_CN_SHIFT   =3;
 CV_DEPTH_MAX  = (1 shl CV_CN_SHIFT);

 CV_8U   =0;
 CV_8S   =1;
 CV_16U  =2;
 CV_16S  =3;
 CV_32S  =4;
 CV_32F  =5;
 CV_64F  =6;
 CV_USRTYPE1 =7;

//#define CV_MAKETYPE(depth,cn) ((depth) + (((cn)-1) << CV_CN_SHIFT))
//#define CV_MAKE_TYPE CV_MAKETYPE
//
//#define CV_8UC1 CV_MAKETYPE(CV_8U,1)
//#define CV_8UC2 CV_MAKETYPE(CV_8U,2)
//#define CV_8UC3 CV_MAKETYPE(CV_8U,3)
//#define CV_8UC4 CV_MAKETYPE(CV_8U,4)
//#define CV_8UC(n) CV_MAKETYPE(CV_8U,(n))
//
//#define CV_8SC1 CV_MAKETYPE(CV_8S,1)
//#define CV_8SC2 CV_MAKETYPE(CV_8S,2)
//#define CV_8SC3 CV_MAKETYPE(CV_8S,3)
//#define CV_8SC4 CV_MAKETYPE(CV_8S,4)
//#define CV_8SC(n) CV_MAKETYPE(CV_8S,(n))
//
//#define CV_16UC1 CV_MAKETYPE(CV_16U,1)
//#define CV_16UC2 CV_MAKETYPE(CV_16U,2)
//#define CV_16UC3 CV_MAKETYPE(CV_16U,3)
//#define CV_16UC4 CV_MAKETYPE(CV_16U,4)
//#define CV_16UC(n) CV_MAKETYPE(CV_16U,(n))
//
//#define CV_16SC1 CV_MAKETYPE(CV_16S,1)
//#define CV_16SC2 CV_MAKETYPE(CV_16S,2)
//#define CV_16SC3 CV_MAKETYPE(CV_16S,3)
//#define CV_16SC4 CV_MAKETYPE(CV_16S,4)
//#define CV_16SC(n) CV_MAKETYPE(CV_16S,(n))
//
//#define CV_32SC1 CV_MAKETYPE(CV_32S,1)
//#define CV_32SC2 CV_MAKETYPE(CV_32S,2)
//#define CV_32SC3 CV_MAKETYPE(CV_32S,3)
//#define CV_32SC4 CV_MAKETYPE(CV_32S,4)
//#define CV_32SC(n) CV_MAKETYPE(CV_32S,(n))
//
//#define CV_32FC1 CV_MAKETYPE(CV_32F,1)
//#define CV_32FC2 CV_MAKETYPE(CV_32F,2)
//#define CV_32FC3 CV_MAKETYPE(CV_32F,3)
//#define CV_32FC4 CV_MAKETYPE(CV_32F,4)
//#define CV_32FC(n) CV_MAKETYPE(CV_32F,(n))
//
//#define CV_64FC1 CV_MAKETYPE(CV_64F,1)
//#define CV_64FC2 CV_MAKETYPE(CV_64F,2)
//#define CV_64FC3 CV_MAKETYPE(CV_64F,3)
//#define CV_64FC4 CV_MAKETYPE(CV_64F,4)
//#define CV_64FC(n) CV_MAKETYPE(CV_64F,(n))

CV_AUTO_STEP = $7fffffff;

//#define CV_WHOLE_ARR  cvSlice( 0, 0x3fffffff )
//
//#define CV_MAT_CN_MASK          ((CV_CN_MAX - 1) << CV_CN_SHIFT)
//#define CV_MAT_CN(flags)        ((((flags) & CV_MAT_CN_MASK) >> CV_CN_SHIFT) + 1)
//#define CV_MAT_DEPTH_MASK       (CV_DEPTH_MAX - 1)
//#define CV_MAT_DEPTH(flags)     ((flags) & CV_MAT_DEPTH_MASK)
//#define CV_MAT_TYPE_MASK        (CV_DEPTH_MAX*CV_CN_MAX - 1)
//#define CV_MAT_TYPE(flags)      ((flags) & CV_MAT_TYPE_MASK)
//#define CV_MAT_CONT_FLAG_SHIFT  14
//#define CV_MAT_CONT_FLAG        (1 << CV_MAT_CONT_FLAG_SHIFT)
//#define CV_IS_MAT_CONT(flags)   ((flags) & CV_MAT_CONT_FLAG)
//#define CV_IS_CONT_MAT          CV_IS_MAT_CONT
//#define CV_MAT_TEMP_FLAG_SHIFT  15
//#define CV_MAT_TEMP_FLAG        (1 << CV_MAT_TEMP_FLAG_SHIFT)
//#define CV_IS_TEMP_MAT(flags)   ((flags) & CV_MAT_TEMP_FLAG)

CV_MAGIC_MASK = $FFFF0000;
CV_MAT_MAGIC_VAL = $42420000;
CV_TYPE_NAME_MAT = 'opencv-matrix';


type
  PPPCvMat = ^PPCvMat;
  PPCvMat = ^PCvMat;
  PCvMat = ^CvMat;
  CvMat =  packed  record
    type_:integer;
    step: integer;
    //* for internal use only */
    refcount: Pinteger;
    hdr_refcount: integer;

    ptr: PansiChar;
    s: pshortint;
    i: pinteger;
    fl: Psingle;
    db: pdouble;

    rows: integer;
    height: integer;

    cols: integer;
    width: integer;
  end;


//#define CV_IS_MAT_HDR(mat) \
//    ((mat) != NULL && \
//    (((const CvMat*)(mat))->type & CV_MAGIC_MASK) == CV_MAT_MAGIC_VAL && \
//    ((const CvMat*)(mat))->cols > 0 && ((const CvMat*)(mat))->rows > 0)
//
//#define CV_IS_MAT(mat) \
//    (CV_IS_MAT_HDR(mat) && ((const CvMat*)(mat))->data.ptr != NULL)
//
//#define CV_IS_MASK_ARR(mat) \
//    (((mat)->type & (CV_MAT_TYPE_MASK & ~CV_8SC1)) == 0)
//
//#define CV_ARE_TYPES_EQ(mat1, mat2) \
//    ((((mat1)->type ^ (mat2)->type) & CV_MAT_TYPE_MASK) == 0)
//
//#define CV_ARE_CNS_EQ(mat1, mat2) \
//    ((((mat1)->type ^ (mat2)->type) & CV_MAT_CN_MASK) == 0)
//
//#define CV_ARE_DEPTHS_EQ(mat1, mat2) \
//    ((((mat1)->type ^ (mat2)->type) & CV_MAT_DEPTH_MASK) == 0)
//
//#define CV_ARE_SIZES_EQ(mat1, mat2) \
//    ((mat1)->rows == (mat2)->rows && (mat1)->cols == (mat2)->cols)
//
//#define CV_IS_MAT_CONST(mat)  \
//    (((mat)->rows|(mat)->cols) == 1)

///* Size of each channel item,
//   0x124489 = 1000 0100 0100 0010 0010 0001 0001 ~ array of sizeof(arr_type_elem) */
//#define CV_ELEM_SIZE1(type) \
//    ((((sizeof(size_t)<<28)|0x8442211) >> CV_MAT_DEPTH(type)*4) & 15)
//
///* 0x3a50 = 11 10 10 01 01 00 00 ~ array of log2(sizeof(arr_type_elem)) */
//#define CV_ELEM_SIZE(type) \
//    (CV_MAT_CN(type) << ((((sizeof(size_t)/4+1)*16384|0x3a50) >> CV_MAT_DEPTH(type)*2) & 3))


///* Inline constructor. No data is allocated internally!!!
// * (Use together with cvCreateData, or use cvCreateMat instead to
// * get a matrix with allocated data):
// */
//CV_INLINE CvMat cvMat( int rows, int cols, int type, void* data CV_DEFAULT(NULL))
//{
//    CvMat m;
//
//    assert( (unsigned)CV_MAT_DEPTH(type) <= CV_64F );
//    type = CV_MAT_TYPE(type);
//    m.type = CV_MAT_MAGIC_VAL | CV_MAT_CONT_FLAG | type;
//    m.cols = cols;
//    m.rows = rows;
//    m.step = rows > 1 ? m.cols*CV_ELEM_SIZE(type) : 0;
//    m.data.ptr = (uchar*)data;
//    m.refcount = NULL;
//    m.hdr_refcount = 0;
//
//    return m;
//}



//#define CV_MAT_ELEM_PTR_FAST( mat, row, col, pix_size )  \
//    (assert( (unsigned)(row) < (unsigned)(mat).rows &&   \
//             (unsigned)(col) < (unsigned)(mat).cols ),   \
//     (mat).data.ptr + (size_t)(mat).step*(row) + (pix_size)*(col))
//
//#define CV_MAT_ELEM_PTR( mat, row, col )                 \
//    CV_MAT_ELEM_PTR_FAST( mat, row, col, CV_ELEM_SIZE((mat).type) )
//
//#define CV_MAT_ELEM( mat, elemtype, row, col )           \
//    (*(elemtype*)CV_MAT_ELEM_PTR_FAST( mat, row, col, sizeof(elemtype)))
//
//
//CV_INLINE  double  cvmGet( const CvMat* mat, int row, int col )
//{
//    int type;
//
//    type = CV_MAT_TYPE(mat->type);
//    assert( (unsigned)row < (unsigned)mat->rows &&
//            (unsigned)col < (unsigned)mat->cols );
//
//    if( type == CV_32FC1 )
//        return ((float*)(mat->data.ptr + (size_t)mat->step*row))[col];
//    else
//    {
//        assert( type == CV_64FC1 );
//        return ((double*)(mat->data.ptr + (size_t)mat->step*row))[col];
//    }
//}
//
//
//CV_INLINE  void  cvmSet( CvMat* mat, int row, int col, double value )
//{
//    int type;
//    type = CV_MAT_TYPE(mat->type);
//    assert( (unsigned)row < (unsigned)mat->rows &&
//            (unsigned)col < (unsigned)mat->cols );
//
//    if( type == CV_32FC1 )
//        ((float*)(mat->data.ptr + (size_t)mat->step*row))[col] = (float)value;
//    else
//    {
//        assert( type == CV_64FC1 );
//        ((double*)(mat->data.ptr + (size_t)mat->step*row))[col] = (double)value;
//    }
//}
//
//
//CV_INLINE int cvCvToIplDepth( int type )
//{
//    int depth = CV_MAT_DEPTH(type);
//    return CV_ELEM_SIZE1(depth)*8 | (depth == CV_8S || depth == CV_16S ||
//           depth == CV_32S ? IPL_DEPTH_SIGN : 0);
//}



///****************************************************************************************\
//*                       Multi-dimensional dense array (CvMatND)                          *
//\****************************************************************************************/

const
  CV_MATND_MAGIC_VAL =  $42430000;
  CV_TYPE_NAME_MATND = 'opencv-nd-matrix';

  CV_MAX_DIM = 32;
  CV_MAX_DIM_HEAP = 1 shl 16;


//typedef struct CvMatND
//{
//    int type;
//    int dims;
//
//    int* refcount;
//    int hdr_refcount;
//
//    union
//    {
//        uchar* ptr;
//        float* fl;
//        double* db;
//        int* i;
//        short* s;
//    } data;
//
//    struct
//    {
//        int size;
//        int step;
//    }
//    dim[CV_MAX_DIM];
//}
//CvMatND;
//
//#define CV_IS_MATND_HDR(mat) \
//    ((mat) != NULL && (((const CvMatND*)(mat))->type & CV_MAGIC_MASK) == CV_MATND_MAGIC_VAL)
//
//#define CV_IS_MATND(mat) \
//    (CV_IS_MATND_HDR(mat) && ((const CvMatND*)(mat))->data.ptr != NULL)
//


///****************************************************************************************\
//*                      Multi-dimensional sparse array (CvSparseMat)                      *
//\****************************************************************************************/
CV_SPARSE_MAT_MAGIC_VAL = $42440000;
CV_TYPE_NAME_SPARSE_MAT = 'opencv-sparse-matrix';

type
  PCvSet = ^CvSet;
  CvSet =  packed  record
  end;



//typedef struct CvSparseMat
//{
//    int type;
//    int dims;
//    int* refcount;
//    int hdr_refcount;
//
//    struct CvSet* heap;
//    void** hashtable;
//    int hashsize;
//    int valoffset;
//    int idxoffset;
//    int size[CV_MAX_DIM];
//}
//CvSparseMat;
//
//#define CV_IS_SPARSE_MAT_HDR(mat) \
//    ((mat) != NULL && \
//    (((const CvSparseMat*)(mat))->type & CV_MAGIC_MASK) == CV_SPARSE_MAT_MAGIC_VAL)
//
//#define CV_IS_SPARSE_MAT(mat) \
//    CV_IS_SPARSE_MAT_HDR(mat)
//
///**************** iteration through a sparse array *****************/
//
//typedef struct CvSparseNode
//{
//    unsigned hashval;
//    struct CvSparseNode* next;
//}
//CvSparseNode;
//
//typedef struct CvSparseMatIterator
//{
//    CvSparseMat* mat;
//    CvSparseNode* node;
//    int curidx;
//}
//CvSparseMatIterator;
//
//#define CV_NODE_VAL(mat,node)   ((void*)((uchar*)(node) + (mat)->valoffset))
//#define CV_NODE_IDX(mat,node)   ((int*)((uchar*)(node) + (mat)->idxoffset))

//
///****************************************************************************************\
//*                                         Histogram                                      *
//\****************************************************************************************/
//
//typedef int CvHistType;
//
//#define CV_HIST_MAGIC_VAL     0x42450000
//#define CV_HIST_UNIFORM_FLAG  (1 << 10)
//
///* indicates whether bin ranges are set already or not */
//#define CV_HIST_RANGES_FLAG   (1 << 11)
//
//#define CV_HIST_ARRAY         0
//#define CV_HIST_SPARSE        1
//#define CV_HIST_TREE          CV_HIST_SPARSE
//
///* should be used as a parameter only,
//   it turns to CV_HIST_UNIFORM_FLAG of hist->type */
//#define CV_HIST_UNIFORM       1
//
//typedef struct CvHistogram
//{
//    int     type;
//    CvArr*  bins;
//    float   thresh[CV_MAX_DIM][2];  /* For uniform histograms.                      */
//    float** thresh2;                /* For non-uniform histograms.                  */
//    CvMatND mat;                    /* Embedded matrix header for array histograms. */
//}
//CvHistogram;
//
//#define CV_IS_HIST( hist ) \
//    ((hist) != NULL  && \
//     (((CvHistogram*)(hist))->type & CV_MAGIC_MASK) == CV_HIST_MAGIC_VAL && \
//     (hist)->bins != NULL)
//
//#define CV_IS_UNIFORM_HIST( hist ) \
//    (((hist)->type & CV_HIST_UNIFORM_FLAG) != 0)
//
//#define CV_IS_SPARSE_HIST( hist ) \
//    CV_IS_SPARSE_MAT((hist)->bins)
//
//#define CV_HIST_HAS_RANGES( hist ) \
//    (((hist)->type & CV_HIST_RANGES_FLAG) != 0)
//
///****************************************************************************************\
//*                      Other supplementary data type definitions                         *
//\****************************************************************************************/
//
///*************************************** CvRect *****************************************/
 type

  PCvRect = ^CvRect;
  CvRect =  packed record
     x: integer;
     y: integer;
     width: integer;
     height: integer;
  end;

  function CvRectV(fx,fy,fw,fh: integer): CvRect ;
  function cvRectToROI(rect: CvRect; coi: integer): IplROI;
  function cvROIToRect(roi:IplROI): CvRect;

///*********************************** CvTermCriteria *************************************/
//
const
 CV_TERMCRIT_ITER  =  1;
 CV_TERMCRIT_NUMBER=  CV_TERMCRIT_ITER;
 CV_TERMCRIT_EPS   =  2;
//
type
CvTermCriteria =  packed record
  type_: integer;  ///* may be combination of
                   //  CV_TERMCRIT_ITER
                   //  CV_TERMCRIT_EPS */
  max_iter: integer;
  epsilon:double ;
end;
//
//CV_INLINE  CvTermCriteria  cvTermCriteria( int type, int max_iter, double epsilon )
//{
//    CvTermCriteria t;
//
//    t.type = type;
//    t.max_iter = max_iter;
//    t.epsilon = (float)epsilon;
//
//    return t;
//}

type
  PPCvPoint = ^PCvPoint;
  PCvPoint = ^CvPoint;
  CvPoint =  packed record
    x,y: integer;
  end;
  function cvPointV(p_x,p_y: integer):CvPoint ;

  type
  CvPoint2D32f =  packed record
    x,y: single;
  end;

  function cvPoint2D32fV(x,y: double):CvPoint2D32f;


//CV_INLINE  CvPoint2D32f  cvPointTo32f( CvPoint point )
//{
//    return cvPoint2D32f( (float)point.x, (float)point.y );
//}
//
//
//CV_INLINE  CvPoint  cvPointFrom32f( CvPoint2D32f point )
//{
//    CvPoint ipt;
//    ipt.x = cvRound(point.x);
//    ipt.y = cvRound(point.y);
//
//    return ipt;
//}
//
//
//typedef struct CvPoint3D32f
//{
//    float x;
//    float y;
//    float z;
//}
//CvPoint3D32f;
//
//
//CV_INLINE  CvPoint3D32f  cvPoint3D32f( double x, double y, double z )
//{
//    CvPoint3D32f p;
//
//    p.x = (float)x;
//    p.y = (float)y;
//    p.z = (float)z;
//
//    return p;
//}
//
//
//typedef struct CvPoint2D64f
//{
//    double x;
//    double y;
//}
//CvPoint2D64f;
//
//
//CV_INLINE  CvPoint2D64f  cvPoint2D64f( double x, double y )
//{
//    CvPoint2D64f p;
//
//    p.x = x;
//    p.y = y;
//
//    return p;
//}
//
//
//typedef struct CvPoint3D64f
//{
//    double x;
//    double y;
//    double z;
//}
//CvPoint3D64f;
//
//
//CV_INLINE  CvPoint3D64f  cvPoint3D64f( double x, double y, double z )
//{
//    CvPoint3D64f p;
//
//    p.x = x;
//    p.y = y;
//    p.z = z;
//
//    return p;
//}



///******************************* CvPoint and variants ***********************************/
//
//typedef struct CvPoint
//{
//    int x;
//    int y;
//}
//CvPoint;
//
//
//CV_INLINE  CvPoint  cvPoint( int x, int y )
//{
//    CvPoint p;
//
//    p.x = x;
//    p.y = y;
//
//    return p;
//}
//
//
//typedef struct CvPoint2D32f
//{
//    float x;
//    float y;
//}
//CvPoint2D32f;
//
//
//CV_INLINE  CvPoint2D32f  cvPoint2D32f( double x, double y )
//{
//    CvPoint2D32f p;
//
//    p.x = (float)x;
//    p.y = (float)y;
//
//    return p;
//}
//
//
//CV_INLINE  CvPoint2D32f  cvPointTo32f( CvPoint point )
//{
//    return cvPoint2D32f( (float)point.x, (float)point.y );
//}
//
//
//CV_INLINE  CvPoint  cvPointFrom32f( CvPoint2D32f point )
//{
//    CvPoint ipt;
//    ipt.x = cvRound(point.x);
//    ipt.y = cvRound(point.y);
//
//    return ipt;
//}
//
//
//typedef struct CvPoint3D32f
//{
//    float x;
//    float y;
//    float z;
//}
//CvPoint3D32f;
//
//
//CV_INLINE  CvPoint3D32f  cvPoint3D32f( double x, double y, double z )
//{
//    CvPoint3D32f p;
//
//    p.x = (float)x;
//    p.y = (float)y;
//    p.z = (float)z;
//
//    return p;
//}
//
//
//typedef struct CvPoint2D64f
//{
//    double x;
//    double y;
//}
//CvPoint2D64f;
//
//
//CV_INLINE  CvPoint2D64f  cvPoint2D64f( double x, double y )
//{
//    CvPoint2D64f p;
//
//    p.x = x;
//    p.y = y;
//
//    return p;
//}
//
//
//typedef struct CvPoint3D64f
//{
//    double x;
//    double y;
//    double z;
//}
//CvPoint3D64f;
//
//
//CV_INLINE  CvPoint3D64f  cvPoint3D64f( double x, double y, double z )
//{
//    CvPoint3D64f p;
//
//    p.x = x;
//    p.y = y;
//    p.z = z;
//
//    return p;
//}
//
//
///******************************** CvSize's & CvBox **************************************/
//
 type
  PCvSize = ^CvSize;
  CvSize =  packed  record
    width: integer;
    height: integer;
  end;

  function CvSizeV(p_width, p_height: integer):CvSize; overload;
  function CvSizeV(p_width, p_height: extended):CvSize; overload;


//typedef struct CvSize2D32f
//{
//    float width;
//    float height;
//}
//CvSize2D32f;
//
//
//CV_INLINE  CvSize2D32f  cvSize2D32f( double width, double height )
//{
//    CvSize2D32f s;
//
//    s.width = (float)width;
//    s.height = (float)height;
//
//    return s;
//}
//
//typedef struct CvBox2D
//{
//    CvPoint2D32f center;  /* Center of the box.                          */
//    CvSize2D32f  size;    /* Box width and length.                       */
//    float angle;          /* Angle between the horizontal axis           */
//                          /* and the first side (i.e. length) in degrees */
//}
//CvBox2D;
//
//
///* Line iterator state: */
//typedef struct CvLineIterator
//{
//    /* Pointer to the current point: */
//    uchar* ptr;
//
//    /* Bresenham algorithm state: */
//    int  err;
//    int  plus_delta;
//    int  minus_delta;
//    int  plus_step;
//    int  minus_step;
//}
//CvLineIterator;
//
//
//
///************************************* CvSlice ******************************************/
//
type CvSlice = packed  record
 start_index, end_index: integer;
end;

function CvSliceV(start_,end_: integer): CvSlice;
//CV_INLINE  CvSlice  cvSlice( int start, int end )
//{
//    CvSlice slice;
//    slice.start_index = start;
//    slice.end_index = end;
//
//    return slice;
//}
//
const CV_WHOLE_SEQ_END_INDEX = $3fffffff;
function CV_WHOLE_SEQ :cvSlice;

//
//
///************************************* CvScalar *****************************************/
//
//typedef struct CvScalar
//{
//    double val[4];
//}
//CvScalar;
//
//CV_INLINE  CvScalar  cvScalar( double val0, double val1 CV_DEFAULT(0),
//                               double val2 CV_DEFAULT(0), double val3 CV_DEFAULT(0))
//{
//    CvScalar scalar;
//    scalar.val[0] = val0; scalar.val[1] = val1;
//    scalar.val[2] = val2; scalar.val[3] = val3;
//    return scalar;
//}
//
//
//CV_INLINE  CvScalar  cvRealScalar( double val0 )
//{
//    CvScalar scalar;
//    scalar.val[0] = val0;
//    scalar.val[1] = scalar.val[2] = scalar.val[3] = 0;
//    return scalar;
//}
//
//CV_INLINE  CvScalar  cvScalarAll( double val0123 )
//{
//    CvScalar scalar;
//    scalar.val[0] = val0123;
//    scalar.val[1] = val0123;
//    scalar.val[2] = val0123;
//    scalar.val[3] = val0123;
//    return scalar;
//}
//
///****************************************************************************************\
//*                                   Dynamic Data structures                              *
//\****************************************************************************************/
//
///******************************** Memory storage ****************************************/

type
  PCvMemBlock = ^CvMemBlock;
  CvMemBlock =  packed  record
    prev: PCvMemBlock;
    next: PCvMemBlock;
  end;

const
 CV_STORAGE_MAGIC_VAL = $42890000;
type

  PCvMemStorage = ^CvMemStorage;
  CvMemStorage =  packed   record
    signature: integer;
    bottom:PCvMemBlock;
    top:PCvMemBlock;
    parent: PCvMemStorage;
    block_size: integer;
    free_space: integer;
  end;


//#define CV_IS_STORAGE(storage)  \
//    ((storage) != NULL &&       \
//    (((CvMemStorage*)(storage))->signature & CV_MAGIC_MASK) == CV_STORAGE_MAGIC_VAL)
//
//
//typedef struct CvMemStoragePos
//{
//    CvMemBlock* top;
//    int free_space;
//}
//CvMemStoragePos;


///*********************************** Sequence *******************************************/
type
  PCvSeqBlock= ^CvSeqBlock;
  CvSeqBlock =  packed  record
    prev: PCvSeqBlock;
    next: PCvSeqBlock;
    start_index: integer;
    count: integer;
    data: pansichar;
  end;

  PPCvSeq = ^PCvSeq;
  PCvSeq = ^CvSeq;
  //CV_SEQUENCE_FIELDS
  CvSeq =  packed  record
    //   CV_TREE_NODE_FIELDS
    flags: integer;
    header_size: integer;
    h_prev: pointer;
    h_next: pointer;
    v_prev: pointer;
    v_next: pointer;
    //    END CV_TREE_NODE_FIELDS

    total: integer;
    elem_size: integer;
    block_max: pansichar;
    ptr: pansichar;
    delta_elems: integer;
    storage: PCvMemStorage;
    free_blocks: PCvSeqBlock;
    first: PCvSeqBlock;
  end;

const
  CV_TYPE_NAME_SEQ =  'opencv-sequence';
  CV_TYPE_NAME_SEQ_TREE = 'opencv-sequence-tree';

///*************************************** Set ********************************************/
///*
//  Set.
//  Order is not preserved. There can be gaps between sequence elements.
//  After the element has been inserted it stays in the same place all the time.
//  The MSB(most-significant or sign bit) of the first field (flags) is 0 iff the element exists.
//*/
//#define CV_SET_ELEM_FIELDS(elem_type)   \
//    int  flags;                         \
//    struct elem_type* next_free;
//
//typedef struct CvSetElem
//{
//    CV_SET_ELEM_FIELDS(CvSetElem)
//}
//CvSetElem;
//
//#define CV_SET_FIELDS()      \
//    CV_SEQUENCE_FIELDS()     \
//    CvSetElem* free_elems;   \
//    int active_count;
//
//typedef struct CvSet
//{
//    CV_SET_FIELDS()
//}
//CvSet;
//
//
//#define CV_SET_ELEM_IDX_MASK   ((1 << 26) - 1)
//#define CV_SET_ELEM_FREE_FLAG  (1 << (sizeof(int)*8-1))
//
///* Checks whether the element pointed by ptr belongs to a set or not */
//#define CV_IS_SET_ELEM( ptr )  (((CvSetElem*)(ptr))->flags >= 0)
//
///************************************* Graph ********************************************/


//
///*
//  We represent a graph as a set of vertices.
//  Vertices contain their adjacency lists (more exactly, pointers to first incoming or
//  outcoming edge (or 0 if isolated vertex)). Edges are stored in another set.
//  There is a singly-linked list of incoming/outcoming edges for each vertex.
//
//  Each edge consists of
//
//     o   Two pointers to the starting and ending vertices
//         (vtx[0] and vtx[1] respectively).
//
//	 A graph may be oriented or not. In the latter case, edges between
//	 vertex i to vertex j are not distinguished during search operations.
//
//     o   Two pointers to next edges for the starting and ending vertices, where
//         next[0] points to the next edge in the vtx[0] adjacency list and
//         next[1] points to the next edge in the vtx[1] adjacency list.
//*/
//#define CV_GRAPH_EDGE_FIELDS()      \
//    int flags;                      \
//    float weight;                   \
//    struct CvGraphEdge* next[2];    \
//    struct CvGraphVtx* vtx[2];
//
//
//#define CV_GRAPH_VERTEX_FIELDS()    \
//    int flags;                      \
//    struct CvGraphEdge* first;
//
//
//typedef struct CvGraphEdge
//{
//    CV_GRAPH_EDGE_FIELDS()
//}
//CvGraphEdge;
//
//typedef struct CvGraphVtx
//{
//    CV_GRAPH_VERTEX_FIELDS()
//}
//CvGraphVtx;
//
//typedef struct CvGraphVtx2D
//{
//    CV_GRAPH_VERTEX_FIELDS()
//    CvPoint2D32f* ptr;
//}
//CvGraphVtx2D;
//
///*
//   Graph is "derived" from the set (this is set a of vertices)
//   and includes another set (edges)
//*/
//#define  CV_GRAPH_FIELDS()   \
//    CV_SET_FIELDS()          \
//    CvSet* edges;
//
//typedef struct CvGraph
//{
//    CV_GRAPH_FIELDS()
//}
//CvGraph;
//
//#define CV_TYPE_NAME_GRAPH "opencv-graph"
//
///*********************************** Chain/Countour *************************************/
//
//typedef struct CvChain
//{
//    CV_SEQUENCE_FIELDS()
//    CvPoint  origin;
//}
//CvChain;
//
//#define CV_CONTOUR_FIELDS()  \
//    CV_SEQUENCE_FIELDS()     \
//    CvRect rect;             \
//    int color;               \
//    int reserved[3];
//
type
PCvContour = ^CvContour;
CvContour =  packed  record
 // CV_SEQUENCE_FIELDS START
    //   CV_TREE_NODE_FIELDS
    flags: integer;
    header_size: integer;
    h_prev: pointer;
    h_next: pointer;
    v_prev: pointer;
    v_next: pointer;
    //    END CV_TREE_NODE_FIELDS

    total: integer;
    elem_size: integer;
    block_max: pansichar;
    ptr: pansichar;
    delta_elems: integer;
    storage: PCvMemStorage;
    free_blocks: PCvSeqBlock;
    first: PCvSeqBlock;
 // CV_SEQUENCE_FIELDS END


  rect: CvRect;
  color: integer;
  reserved: array[0..2] of integer;
end;

//typedef struct CvContour
//{
//    CV_CONTOUR_FIELDS()
//}
//CvContour;
//
//typedef CvContour CvPoint2DSeq;
//
///****************************************************************************************\
//*                                    Sequence types                                      *
//\****************************************************************************************/
//
//#define CV_SEQ_MAGIC_VAL             0x42990000
//
//#define CV_IS_SEQ(seq) \
//    ((seq) != NULL && (((CvSeq*)(seq))->flags & CV_MAGIC_MASK) == CV_SEQ_MAGIC_VAL)
//
//#define CV_SET_MAGIC_VAL             0x42980000
//#define CV_IS_SET(set) \
//    ((set) != NULL && (((CvSeq*)(set))->flags & CV_MAGIC_MASK) == CV_SET_MAGIC_VAL)
//
//#define CV_SEQ_ELTYPE_BITS           9
//#define CV_SEQ_ELTYPE_MASK           ((1 << CV_SEQ_ELTYPE_BITS) - 1)
//
//#define CV_SEQ_ELTYPE_POINT          CV_32SC2  /* (x,y) */
//#define CV_SEQ_ELTYPE_CODE           CV_8UC1   /* freeman code: 0..7 */
//#define CV_SEQ_ELTYPE_GENERIC        0
//#define CV_SEQ_ELTYPE_PTR            CV_USRTYPE1
//#define CV_SEQ_ELTYPE_PPOINT         CV_SEQ_ELTYPE_PTR  /* &(x,y) */
//#define CV_SEQ_ELTYPE_INDEX          CV_32SC1  /* #(x,y) */
//#define CV_SEQ_ELTYPE_GRAPH_EDGE     0  /* &next_o, &next_d, &vtx_o, &vtx_d */
//#define CV_SEQ_ELTYPE_GRAPH_VERTEX   0  /* first_edge, &(x,y) */
//#define CV_SEQ_ELTYPE_TRIAN_ATR      0  /* vertex of the binary tree   */
//#define CV_SEQ_ELTYPE_CONNECTED_COMP 0  /* connected component  */
//#define CV_SEQ_ELTYPE_POINT3D        CV_32FC3  /* (x,y,z)  */
//
//#define CV_SEQ_KIND_BITS        3
//#define CV_SEQ_KIND_MASK        (((1 << CV_SEQ_KIND_BITS) - 1)<<CV_SEQ_ELTYPE_BITS)
//
///* types of sequences */
//#define CV_SEQ_KIND_GENERIC     (0 << CV_SEQ_ELTYPE_BITS)
//#define CV_SEQ_KIND_CURVE       (1 << CV_SEQ_ELTYPE_BITS)
//#define CV_SEQ_KIND_BIN_TREE    (2 << CV_SEQ_ELTYPE_BITS)
//
///* types of sparse sequences (sets) */
//#define CV_SEQ_KIND_GRAPH       (3 << CV_SEQ_ELTYPE_BITS)
//#define CV_SEQ_KIND_SUBDIV2D    (4 << CV_SEQ_ELTYPE_BITS)
//
//#define CV_SEQ_FLAG_SHIFT       (CV_SEQ_KIND_BITS + CV_SEQ_ELTYPE_BITS)
//
///* flags for curves */
//#define CV_SEQ_FLAG_CLOSED     (1 << CV_SEQ_FLAG_SHIFT)
//#define CV_SEQ_FLAG_SIMPLE     (2 << CV_SEQ_FLAG_SHIFT)
//#define CV_SEQ_FLAG_CONVEX     (4 << CV_SEQ_FLAG_SHIFT)
//#define CV_SEQ_FLAG_HOLE       (8 << CV_SEQ_FLAG_SHIFT)
//
///* flags for graphs */
//#define CV_GRAPH_FLAG_ORIENTED (1 << CV_SEQ_FLAG_SHIFT)
//
//#define CV_GRAPH               CV_SEQ_KIND_GRAPH
//#define CV_ORIENTED_GRAPH      (CV_SEQ_KIND_GRAPH|CV_GRAPH_FLAG_ORIENTED)
//
///* point sets */
//#define CV_SEQ_POINT_SET       (CV_SEQ_KIND_GENERIC| CV_SEQ_ELTYPE_POINT)
//#define CV_SEQ_POINT3D_SET     (CV_SEQ_KIND_GENERIC| CV_SEQ_ELTYPE_POINT3D)
//#define CV_SEQ_POLYLINE        (CV_SEQ_KIND_CURVE  | CV_SEQ_ELTYPE_POINT)
//#define CV_SEQ_POLYGON         (CV_SEQ_FLAG_CLOSED | CV_SEQ_POLYLINE )
//#define CV_SEQ_CONTOUR         CV_SEQ_POLYGON
//#define CV_SEQ_SIMPLE_POLYGON  (CV_SEQ_FLAG_SIMPLE | CV_SEQ_POLYGON  )
//
///* chain-coded curves */
//#define CV_SEQ_CHAIN           (CV_SEQ_KIND_CURVE  | CV_SEQ_ELTYPE_CODE)
//#define CV_SEQ_CHAIN_CONTOUR   (CV_SEQ_FLAG_CLOSED | CV_SEQ_CHAIN)
//
///* binary tree for the contour */
//#define CV_SEQ_POLYGON_TREE    (CV_SEQ_KIND_BIN_TREE  | CV_SEQ_ELTYPE_TRIAN_ATR)
//
///* sequence of the connected components */
//#define CV_SEQ_CONNECTED_COMP  (CV_SEQ_KIND_GENERIC  | CV_SEQ_ELTYPE_CONNECTED_COMP)
//
///* sequence of the integer numbers */
//#define CV_SEQ_INDEX           (CV_SEQ_KIND_GENERIC  | CV_SEQ_ELTYPE_INDEX)
//
//#define CV_SEQ_ELTYPE( seq )   ((seq)->flags & CV_SEQ_ELTYPE_MASK)
//#define CV_SEQ_KIND( seq )     ((seq)->flags & CV_SEQ_KIND_MASK )
//
///* flag checking */
//#define CV_IS_SEQ_INDEX( seq )      ((CV_SEQ_ELTYPE(seq) == CV_SEQ_ELTYPE_INDEX) && \
//                                     (CV_SEQ_KIND(seq) == CV_SEQ_KIND_GENERIC))
//
//#define CV_IS_SEQ_CURVE( seq )      (CV_SEQ_KIND(seq) == CV_SEQ_KIND_CURVE)
//#define CV_IS_SEQ_CLOSED( seq )     (((seq)->flags & CV_SEQ_FLAG_CLOSED) != 0)
//#define CV_IS_SEQ_CONVEX( seq )     (((seq)->flags & CV_SEQ_FLAG_CONVEX) != 0)
//#define CV_IS_SEQ_HOLE( seq )       (((seq)->flags & CV_SEQ_FLAG_HOLE) != 0)
//#define CV_IS_SEQ_SIMPLE( seq )     ((((seq)->flags & CV_SEQ_FLAG_SIMPLE) != 0) || \
//                                    CV_IS_SEQ_CONVEX(seq))
//
///* type checking macros */
//#define CV_IS_SEQ_POINT_SET( seq ) \
//    ((CV_SEQ_ELTYPE(seq) == CV_32SC2 || CV_SEQ_ELTYPE(seq) == CV_32FC2))
//
//#define CV_IS_SEQ_POINT_SUBSET( seq ) \
//    (CV_IS_SEQ_INDEX( seq ) || CV_SEQ_ELTYPE(seq) == CV_SEQ_ELTYPE_PPOINT)
//
//#define CV_IS_SEQ_POLYLINE( seq )   \
//    (CV_SEQ_KIND(seq) == CV_SEQ_KIND_CURVE && CV_IS_SEQ_POINT_SET(seq))
//
//#define CV_IS_SEQ_POLYGON( seq )   \
//    (CV_IS_SEQ_POLYLINE(seq) && CV_IS_SEQ_CLOSED(seq))
//
//#define CV_IS_SEQ_CHAIN( seq )   \
//    (CV_SEQ_KIND(seq) == CV_SEQ_KIND_CURVE && (seq)->elem_size == 1)
//
//#define CV_IS_SEQ_CONTOUR( seq )   \
//    (CV_IS_SEQ_CLOSED(seq) && (CV_IS_SEQ_POLYLINE(seq) || CV_IS_SEQ_CHAIN(seq)))
//
//#define CV_IS_SEQ_CHAIN_CONTOUR( seq ) \
//    (CV_IS_SEQ_CHAIN( seq ) && CV_IS_SEQ_CLOSED( seq ))
//
//#define CV_IS_SEQ_POLYGON_TREE( seq ) \
//    (CV_SEQ_ELTYPE (seq) ==  CV_SEQ_ELTYPE_TRIAN_ATR &&    \
//    CV_SEQ_KIND( seq ) ==  CV_SEQ_KIND_BIN_TREE )
//
//#define CV_IS_GRAPH( seq )    \
//    (CV_IS_SET(seq) && CV_SEQ_KIND((CvSet*)(seq)) == CV_SEQ_KIND_GRAPH)
//
//#define CV_IS_GRAPH_ORIENTED( seq )   \
//    (((seq)->flags & CV_GRAPH_FLAG_ORIENTED) != 0)
//
//#define CV_IS_SUBDIV2D( seq )  \
//    (CV_IS_SET(seq) && CV_SEQ_KIND((CvSet*)(seq)) == CV_SEQ_KIND_SUBDIV2D)
//
///****************************************************************************************/
///*                            Sequence writer & reader                                  */
///****************************************************************************************/
//
//#define CV_SEQ_WRITER_FIELDS()                                     \
//    int          header_size;                                      \
//    CvSeq*       seq;        /* the sequence written */            \
//    CvSeqBlock*  block;      /* current block */                   \
//    schar*       ptr;        /* pointer to free space */           \
//    schar*       block_min;  /* pointer to the beginning of block*/\
//    schar*       block_max;  /* pointer to the end of block */
//
//typedef struct CvSeqWriter
//{
//    CV_SEQ_WRITER_FIELDS()
//}
//CvSeqWriter;
//
//
//#define CV_SEQ_READER_FIELDS()                                      \
//    int          header_size;                                       \
//    CvSeq*       seq;        /* sequence, beign read */             \
//    CvSeqBlock*  block;      /* current block */                    \
//    schar*       ptr;        /* pointer to element be read next */  \
//    schar*       block_min;  /* pointer to the beginning of block */\
//    schar*       block_max;  /* pointer to the end of block */      \
//    int          delta_index;/* = seq->first->start_index   */      \
//    schar*       prev_elem;  /* pointer to previous element */
//
//
PCvSeqReader = ^CvSeqReader;
CvSeqReader =  packed record
//{
//    CV_SEQ_READER_FIELDS()
//}
//CvSeqReader;
header_size: integer;
seq:PCvSeq;
block:PCvSeqBlock;
ptr:pansichar;
 block_min :pansichar;
 block_max :pansichar;
 delta_index: integer;
 prev_elem: pansichar;
end;
//
///****************************************************************************************/
///*                                Operations on sequences                               */
///****************************************************************************************/
//
//#define  CV_SEQ_ELEM( seq, elem_type, index )                    \
///* assert gives some guarantee that <seq> parameter is valid */  \
//(   assert(sizeof((seq)->first[0]) == sizeof(CvSeqBlock) &&      \
//    (seq)->elem_size == sizeof(elem_type)),                      \
//    (elem_type*)((seq)->first && (unsigned)index <               \
//    (unsigned)((seq)->first->count) ?                            \
//    (seq)->first->data + (index) * sizeof(elem_type) :           \
//    cvGetSeqElem( (CvSeq*)(seq), (index) )))
//#define CV_GET_SEQ_ELEM( elem_type, seq, index ) CV_SEQ_ELEM( (seq), elem_type, (index) )
//
///* Add element to sequence: */
//#define CV_WRITE_SEQ_ELEM_VAR( elem_ptr, writer )     \
//{                                                     \
//    if( (writer).ptr >= (writer).block_max )          \
//    {                                                 \
//        cvCreateSeqBlock( &writer);                   \
//    }                                                 \
//    memcpy((writer).ptr, elem_ptr, (writer).seq->elem_size);\
//    (writer).ptr += (writer).seq->elem_size;          \
//}
//
//#define CV_WRITE_SEQ_ELEM( elem, writer )             \
//{                                                     \
//    assert( (writer).seq->elem_size == sizeof(elem)); \
//    if( (writer).ptr >= (writer).block_max )          \
//    {                                                 \
//        cvCreateSeqBlock( &writer);                   \
//    }                                                 \
//    assert( (writer).ptr <= (writer).block_max - sizeof(elem));\
//    memcpy((writer).ptr, &(elem), sizeof(elem));      \
//    (writer).ptr += sizeof(elem);                     \
//}
//
//
///* Move reader position forward: */
//#define CV_NEXT_SEQ_ELEM( elem_size, reader )                 \
//{                                                             \
//    if( ((reader).ptr += (elem_size)) >= (reader).block_max ) \
//    {                                                         \
//        cvChangeSeqBlock( &(reader), 1 );                     \
//    }                                                         \
//}
procedure CV_NEXT_SEQ_ELEM(elem_size: integer; var reader:CvSeqReader);


//
///* Move reader position backward: */
//#define CV_PREV_SEQ_ELEM( elem_size, reader )                \
//{                                                            \
//    if( ((reader).ptr -= (elem_size)) < (reader).block_min ) \
//    {                                                        \
//        cvChangeSeqBlock( &(reader), -1 );                   \
//    }                                                        \
//}
//
///* Read element and move read position forward: */
//#define CV_READ_SEQ_ELEM( elem, reader )                       \
//{                                                              \
//    assert( (reader).seq->elem_size == sizeof(elem));          \
//    memcpy( &(elem), (reader).ptr, sizeof((elem)));            \
//    CV_NEXT_SEQ_ELEM( sizeof(elem), reader )                   \
//}
procedure CV_READ_SEQ_ELEM(elem: CvPoint; reader:CvSeqReader);

//
///* Read element and move read position backward: */
//#define CV_REV_READ_SEQ_ELEM( elem, reader )                     \
//{                                                                \
//    assert( (reader).seq->elem_size == sizeof(elem));            \
//    memcpy(&(elem), (reader).ptr, sizeof((elem)));               \
//    CV_PREV_SEQ_ELEM( sizeof(elem), reader )                     \
//}
//
//
//#define CV_READ_CHAIN_POINT( _pt, reader )                              \
//{                                                                       \
//    (_pt) = (reader).pt;                                                \
//    if( (reader).ptr )                                                  \
//    {                                                                   \
//        CV_READ_SEQ_ELEM( (reader).code, (reader));                     \
//        assert( ((reader).code & ~7) == 0 );                            \
//        (reader).pt.x += (reader).deltas[(int)(reader).code][0];        \
//        (reader).pt.y += (reader).deltas[(int)(reader).code][1];        \
//    }                                                                   \
//}
//
//#define CV_CURRENT_POINT( reader )  (*((CvPoint*)((reader).ptr)))
//#define CV_PREV_POINT( reader )     (*((CvPoint*)((reader).prev_elem)))
//
//#define CV_READ_EDGE( pt1, pt2, reader )               \
//{                                                      \
//    assert( sizeof(pt1) == sizeof(CvPoint) &&          \
//            sizeof(pt2) == sizeof(CvPoint) &&          \
//            reader.seq->elem_size == sizeof(CvPoint)); \
//    (pt1) = CV_PREV_POINT( reader );                   \
//    (pt2) = CV_CURRENT_POINT( reader );                \
//    (reader).prev_elem = (reader).ptr;                 \
//    CV_NEXT_SEQ_ELEM( sizeof(CvPoint), (reader));      \
//}
//
///************ Graph macros ************/
//
///* Return next graph edge for given vertex: */
//#define  CV_NEXT_GRAPH_EDGE( edge, vertex )                              \
//     (assert((edge)->vtx[0] == (vertex) || (edge)->vtx[1] == (vertex)),  \
//      (edge)->next[(edge)->vtx[1] == (vertex)])
//
//
//
///****************************************************************************************\
//*             Data structures for persistence (a.k.a serialization) functionality        *
//\****************************************************************************************/
//
///* "black box" file storage */
//typedef struct CvFileStorage CvFileStorage;
//
///* Storage flags: */
//#define CV_STORAGE_READ          0
//#define CV_STORAGE_WRITE         1
//#define CV_STORAGE_WRITE_TEXT    CV_STORAGE_WRITE
//#define CV_STORAGE_WRITE_BINARY  CV_STORAGE_WRITE
//#define CV_STORAGE_APPEND        2
//
///* List of attributes: */
//typedef struct CvAttrList
//{
//    const char** attr;         /* NULL-terminated array of (attribute_name,attribute_value) pairs. */
//    struct CvAttrList* next;   /* Pointer to next chunk of the attributes list.                    */
//}
//CvAttrList;
//
//CV_INLINE CvAttrList cvAttrList( const char** attr CV_DEFAULT(NULL),
//                                 CvAttrList* next CV_DEFAULT(NULL) )
//{
//    CvAttrList l;
//    l.attr = attr;
//    l.next = next;
//
//    return l;
//}
//
//struct CvTypeInfo;
//
//#define CV_NODE_NONE        0
//#define CV_NODE_INT         1
//#define CV_NODE_INTEGER     CV_NODE_INT
//#define CV_NODE_REAL        2
//#define CV_NODE_FLOAT       CV_NODE_REAL
//#define CV_NODE_STR         3
//#define CV_NODE_STRING      CV_NODE_STR
//#define CV_NODE_REF         4 /* not used */
//#define CV_NODE_SEQ         5
//#define CV_NODE_MAP         6
//#define CV_NODE_TYPE_MASK   7
//
//#define CV_NODE_TYPE(flags)  ((flags) & CV_NODE_TYPE_MASK)
//
///* file node flags */
//#define CV_NODE_FLOW        8 /* Used only for writing structures in YAML format. */
//#define CV_NODE_USER        16
//#define CV_NODE_EMPTY       32
//#define CV_NODE_NAMED       64
//
//#define CV_NODE_IS_INT(flags)        (CV_NODE_TYPE(flags) == CV_NODE_INT)
//#define CV_NODE_IS_REAL(flags)       (CV_NODE_TYPE(flags) == CV_NODE_REAL)
//#define CV_NODE_IS_STRING(flags)     (CV_NODE_TYPE(flags) == CV_NODE_STRING)
//#define CV_NODE_IS_SEQ(flags)        (CV_NODE_TYPE(flags) == CV_NODE_SEQ)
//#define CV_NODE_IS_MAP(flags)        (CV_NODE_TYPE(flags) == CV_NODE_MAP)
//#define CV_NODE_IS_COLLECTION(flags) (CV_NODE_TYPE(flags) >= CV_NODE_SEQ)
//#define CV_NODE_IS_FLOW(flags)       (((flags) & CV_NODE_FLOW) != 0)
//#define CV_NODE_IS_EMPTY(flags)      (((flags) & CV_NODE_EMPTY) != 0)
//#define CV_NODE_IS_USER(flags)       (((flags) & CV_NODE_USER) != 0)
//#define CV_NODE_HAS_NAME(flags)      (((flags) & CV_NODE_NAMED) != 0)
//
//#define CV_NODE_SEQ_SIMPLE 256
//#define CV_NODE_SEQ_IS_SIMPLE(seq) (((seq)->flags & CV_NODE_SEQ_SIMPLE) != 0)
//
//typedef struct CvString
//{
//    int len;
//    char* ptr;
//}
//CvString;
//
///* All the keys (names) of elements in the readed file storage
//   are stored in the hash to speed up the lookup operations: */
//typedef struct CvStringHashNode
//{
//    unsigned hashval;
//    CvString str;
//    struct CvStringHashNode* next;
//}
//CvStringHashNode;
//
//typedef struct CvGenericHash CvFileNodeHash;
//
///* Basic element of the file storage - scalar or collection: */
//typedef struct CvFileNode
//{
//    int tag;
//    struct CvTypeInfo* info; /* type information
//            (only for user-defined object, for others it is 0) */
//    union
//    {
//        double f; /* scalar floating-point number */
//        int i;    /* scalar integer number */
//        CvString str; /* text string */
//        CvSeq* seq; /* sequence (ordered collection of file nodes) */
//        CvFileNodeHash* map; /* map (collection of named file nodes) */
//    } data;
//}
//CvFileNode;
//
//#ifdef __cplusplus
//extern "C" {
//#endif
//typedef int (CV_CDECL *CvIsInstanceFunc)( const void* struct_ptr );
//typedef void (CV_CDECL *CvReleaseFunc)( void** struct_dblptr );
//typedef void* (CV_CDECL *CvReadFunc)( CvFileStorage* storage, CvFileNode* node );
//typedef void (CV_CDECL *CvWriteFunc)( CvFileStorage* storage, const char* name,
//                                      const void* struct_ptr, CvAttrList attributes );
//typedef void* (CV_CDECL *CvCloneFunc)( const void* struct_ptr );
//#ifdef __cplusplus
//}
//#endif
//
//typedef struct CvTypeInfo
//{
//    int flags;
//    int header_size;
//    struct CvTypeInfo* prev;
//    struct CvTypeInfo* next;
//    const char* type_name;
//    CvIsInstanceFunc is_instance;
//    CvReleaseFunc release;
//    CvReadFunc read;
//    CvWriteFunc write;
//    CvCloneFunc clone;
//}
//CvTypeInfo;
//
//
///**** System data types ******/
//
//typedef struct CvPluginFuncInfo
//{
//    void** func_addr;
//    void* default_func_addr;
//    const char* func_names;
//    int search_modules;
//    int loaded_from;
//}
//CvPluginFuncInfo;
//
//typedef struct CvModuleInfo
//{
//    struct CvModuleInfo* next;
//    const char* name;
//    const char* version;
//    CvPluginFuncInfo* func_tab;
//}
//CvModuleInfo;


type

  CvScalar = record
    val: array[0..3] of double;
  end;

  CvMoments =record
    m00, m10, m01, m20, m11, m02, m30, m21, m12, m03: double;// /* spatial moments */
    mu20, mu11, mu02, mu30, mu21, mu12, mu03: double; ///* central moments */
    inv_sqrt_m00: integer; ///* m00 != 0 ? 1/sqrt(m00) : 0 */
  end;

  CvHuMoments = record
    hu1, hu2, hu3, hu4, hu5, hu6, hu7: double; ///* Hu invariants */
  end;

///**************************** Connected Component  **************************************/

CvConnectedComp= record
  area: double;   ///* area of the connected component  */
  value: CvScalar;///* average color of the connected component */
  rect: CvRect;   ///* ROI of the component  */
  contour: PCvSeq;///* optional component boundary
  ///            (the contour might have child contours corresponding to the holes)*/
end;

const
///* contour retrieval mode */
 CV_RETR_EXTERNAL =0;
 CV_RETR_LIST     =1;
 CV_RETR_CCOMP    =2;
 CV_RETR_TREE     =3;

///* contour approximation method */
 CV_CHAIN_CODE               =0;
 CV_CHAIN_APPROX_NONE        =1;
 CV_CHAIN_APPROX_SIMPLE      =2;
 CV_CHAIN_APPROX_TC89_L1     =3;
 CV_CHAIN_APPROX_TC89_KCOS   =4;
 CV_LINK_RUNS                =5;

type
///* Freeman chain reader state */
CvChainPtReader = record
//  ??
end;



  PCvHaarFeature = ^CvHaarFeature;
  CvHaarFeature =record

  end;

 CvHaarClassifier = record
   count: integer;
   haar_feature: PCvHaarFeature;
   threshold: Psingle;
 end;


  PCvHaarClassifierCascade= ^CvHaarClassifierCascade;
  CvHaarClassifierCascade = record
    flags: integer;
    // threshold: float; ??????
 //   classifier: PCvHaarClassifier;
  end;


  CvAvgComp = record
    rect:   CvRect;
    neighbors: integer;
  end;

  CvFeatureTree = record
  end;




implementation

uses opencv_core;


function CvSizeV(p_width,p_height: integer):CvSize;
begin
  result.width:=p_width;
  Result.height:= p_height;
end;

function CvSizeV(p_width,p_height: extended):CvSize; overload;
begin
  result.width  := round(p_width);
  Result.height := round(p_height);
end;

function cvPointV(p_x,p_y: integer):CvPoint;
begin
  result.x := p_x;
  result.y := p_y;
end;

function CvRectV(fx,fy,fw,fh: integer): CvRect;
begin
  result.x := fx;
  result.y := fy;
  Result.width := fw;
  result.height := fh;
end;

function cvRectToROI(rect: CvRect; coi: integer): IplROI;
begin
    result.xOffset := rect.x;
    result.yOffset := rect.y;
    result.width := rect.width;
    result.height := rect.height;
    result.coi := coi;

end;

function cvROIToRect(roi:IplROI): CvRect;
begin
  result :=  cvRectV( roi.xOffset, roi.yOffset, roi.width, roi.height );
end;
function cvPoint2D32fV(x,y: double):CvPoint2D32f;
begin
  result.x := x;
  result.y := y;
end;


function CV_WHOLE_SEQ :cvSlice;
begin
  result := cvSliceV(0, CV_WHOLE_SEQ_END_INDEX);
end;

function CvSliceV(start_,end_: integer): CvSlice;
begin
  result.start_index:= start_;
  Result.end_index := end_;
end;

procedure CV_READ_SEQ_ELEM(elem: CvPoint; reader:CvSeqReader);
begin
    assert( (reader).seq^.elem_size = sizeof(elem));
//    memcpy( &(elem), (reader).ptr, sizeof((elem)));
    move(reader.ptr, elem,sizeof(elem));
    CV_NEXT_SEQ_ELEM( sizeof(elem), reader )
end;

///* Move reader position forward: */
//#define CV_NEXT_SEQ_ELEM( elem_size, reader )                 \
//{                                                             \
//    if( ((reader).ptr += (elem_size)) >= (reader).block_max ) \
//    {                                                         \
//        cvChangeSeqBlock( &(reader), 1 );                     \
//    }                                                         \
//}
procedure CV_NEXT_SEQ_ELEM(elem_size: integer; var reader:CvSeqReader);
type
  PByteArray = ^ByteArray;
  ByteArray = array[0..$effffff] of byte;
begin
  reader.ptr := reader.ptr + elem_size;
  if reader.ptr>=reader.block_max then
    cvChangeSeqBlock( @(reader), 1 );

//  if @(PByteArray(reader.ptr)^[0+elem_size]) >= reader.block_max then
//    cvChangeSeqBlock( @(reader), 1 );
end;

end.
