## Equations

This document describes the design of the data acquisition, model training,
and model deployment for equation detection, decoding, grounding and conversion
to an executable representation.

### Data acquisition

This step is required for the construction of several datasets meant to be used
for the training and evaluation of the models required for the following steps.

For this purpose we will use papers written in latex downloaded in bulk from
[arXiv](https://arxiv.org/help/bulk_data_s3). Previously, similar datasets
have been constructed but they are limited in scope. Particularly, a sample
of source files from the `hep-th` (High Energy Physics) section of arXiv was
collected in 2003 for the [KDD cup competition](http://www.cs.cornell.edu/projects/kddcup/datasets.html).
Our goal here is to extend this dataset to increase the number of training examples
and to include a variety of domains.

#### Dataset construction pipeline

We will use [`latexmk`](https://mg.readthedocs.io/latexmk.html) to compile the downloaded latex code into PDF.
We expect this process to be relatively simple because of the requirements
established by arXiv for [(La)TeX submission](https://arxiv.org/help/submit_tex).

The source (La)TeX code will be [tokenized](https://github.com/tiarno/plastex) and
scanned for detecting equation related environments. These sequences of tokens will
be stored and will also be rendered into independend images that show the rendered
equation in isolation. This pairing of (La)TeX tokens to rendered equations is the
datased required for the training and evaluation of the equation decoding component
described below.

Next, each page of the rendered document will be [transformed into an image](https://github.com/Belval/pdf2image),
and an axis aligned bounding box (AABB) for the equation in one of the document pages
will be identified by [template matching](https://docs.opencv.org/4.0.0/df/dfb/group__imgproc__object.html).
This mapping of rendered equation to (page, AABB) tuples will be required for the
training and evaluation of the equation detection component described below.

### Equation detection

The purpose of this component is the automatic detection of equations in scientific
papers encoded as PDF files.

TODO talk about [object detection algorithms](https://towardsdatascience.com/r-cnn-fast-r-cnn-faster-r-cnn-yolo-object-detection-algorithms-36d53571365e)

### Equation decoding

The purpose of this component is the automatic conversion of rendered equations into
(La)TeX code.

For this purpose we will use an encoder-decoder architecture capable of encoding
an image into a dense embedding that can subsequentially be decoded into (La)TeX
code capable of being compiled into an image. We have selected (La)TeX as the
intermediary representation between image and executable model because of the
availability of training data (arXiv) and because, due to the nature of (La)TeX,
it preserves typographic information that could be useful for the succesful
interpretation of the equation semantics.

Encoder-decoder architectures like the one proposed have been successfully applied
in the past for the purpose of image caption generation
(e.g., [Show and Tell: Lessons learned from the 2015 MSCOCO Image Captioning Challenge](https://arxiv.org/abs/1609.06647)).

We will start with an existing model previously trained for the purpose of converting
images to markup
(i.e., [Image-to-Markup Generation with Coarse-to-Fine Attention](https://arxiv.org/abs/1609.04938)).
This model was trained with the [2003 KDD cup competition](http://www.cs.cornell.edu/projects/kddcup/datasets.html) sample
of arXiv. We will compare the performance of this pretrained model with the same model trained
using the dataset constructed in the [data acquisition](https://github.com/ml4ai/automates/blob/master/documentation/reports/m1_architecture_report/equations.md#data-acquisition) step. We will also improve the model (TODO how?).

### Equation grounding

The purpose of this component is to identify text descriptions of the equation,
as well as the individual variables that form part of it. This associations of
variable to description will be fundamental for the alignment of equations to
the Fortran source code analysed in other parts of the system.

First, sections of the document that are likely to describe the equation.
Particularly, we will focus on the text surrounding the equation in the document,
and also text that references the equation.

This text will then be processed using a [rule-based grammar](http://www.lrec-conf.org/proceedings/lrec2016/pdf/32_Paper.pdf)
customized for this particular task.

### Equation to executable model

The purpose of this component is to convert the (grounded) (La)TeX representation
of the equation into a Python lambda that executes the equation.

TODO mention [latex2sympy](https://github.com/augustt198/latex2sympy)