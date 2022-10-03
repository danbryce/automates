# coding: utf-8

"""
    Grounded Model Exchange (GroMEt) schema for Function Networks

    This document defines the GroMEt Function Network data model. Note that Metadata is defined in separate spec.  __Using Swagger to Generate Class Structure__  To automatically generate Python or Java models corresponding to this document, you can use [swagger-codegen](https://swagger.io/tools/swagger-codegen/). This can be used to generate the client code based off of this spec, and in the process this will generate the data model class structure.  1. Install via the method described for your operating system    [here](https://github.com/swagger-api/swagger-codegen#Prerequisites).    Make sure to install a version after 3.0 that will support openapi 3. 2. Run swagger-codegen with the options in the example below.    The URL references where the yaml for this documentation is stored on    github. Make sure to replace CURRENT_VERSION with the correct version.    To generate Java classes rather, change the `-l python` to `-l java`.    Change the value to the `-o` option to the desired output location.    ```    swagger-codegen generate -l python -o ./client -i https://raw.githubusercontent.com/ml4ai/automates-v2/master/docs/source/gromet_FN_v{CURRENT_VERSION}.yaml    ``` 3. Once it executes, the client code will be generated at your specified    location.    For python, the classes will be located in    `$OUTPUT_PATH/swagger_client/models/`.    For java, they will be located in    `$OUTPUT_PATH/src/main/java/io/swagger/client/model/`  If generating GroMEt schema data model classes in SKEMA (AutoMATES), then afer generating the above, follow the instructions here: ``` <automates>/automates/model_assembly/gromet/model/README.md ```   # noqa: E501

    OpenAPI spec version: 0.1.2
    Contact: claytonm@arizona.edu
    Generated by: https://github.com/swagger-api/swagger-codegen.git
"""

import pprint
import re  # noqa: F401

import six

class GrometFNModule(object):
    """NOTE: This class is auto generated by the swagger code generator program.

    Do not edit the class manually.
    """
    """
    Attributes:
      swagger_types (dict): The key is attribute name
                            and the value is attribute type.
      attribute_map (dict): The key is attribute name
                            and the value is json key in definition.
    """
    swagger_types = {
        'name': 'str',
        'fn': 'GrometFN',
        'attributes': 'list[TypedValue]',
        'metadata': 'Metadata'
    }

    attribute_map = {
        'name': 'name',
        'fn': 'fn',
        'attributes': 'attributes',
        'metadata': 'metadata'
    }

    def __init__(self, name=None, fn=None, attributes=None, metadata=None):  # noqa: E501
        """GrometFNModule - a model defined in Swagger"""  # noqa: E501
        self._name = None
        self._fn = None
        self._attributes = None
        self._metadata = None
        self.discriminator = None
        if name is not None:
            self.name = name
        if fn is not None:
            self.fn = fn
        if attributes is not None:
            self.attributes = attributes
        if metadata is not None:
            self.metadata = metadata

    @property
    def name(self):
        """Gets the name of this GrometFNModule.  # noqa: E501

        The name of the Function Network Module.   # noqa: E501

        :return: The name of this GrometFNModule.  # noqa: E501
        :rtype: str
        """
        return self._name

    @name.setter
    def name(self, name):
        """Sets the name of this GrometFNModule.

        The name of the Function Network Module.   # noqa: E501

        :param name: The name of this GrometFNModule.  # noqa: E501
        :type: str
        """

        self._name = name

    @property
    def fn(self):
        """Gets the fn of this GrometFNModule.  # noqa: E501


        :return: The fn of this GrometFNModule.  # noqa: E501
        :rtype: GrometFN
        """
        return self._fn

    @fn.setter
    def fn(self, fn):
        """Sets the fn of this GrometFNModule.


        :param fn: The fn of this GrometFNModule.  # noqa: E501
        :type: GrometFN
        """

        self._fn = fn

    @property
    def attributes(self):
        """Gets the attributes of this GrometFNModule.  # noqa: E501

        (sum-type) Array of TypedValues. Currently expect:<br> (1) other GrometFN (type = \"FN\")<br> (2) references to ImportReference (type = \"IMPORT\")   # noqa: E501

        :return: The attributes of this GrometFNModule.  # noqa: E501
        :rtype: list[TypedValue]
        """
        return self._attributes

    @attributes.setter
    def attributes(self, attributes):
        """Sets the attributes of this GrometFNModule.

        (sum-type) Array of TypedValues. Currently expect:<br> (1) other GrometFN (type = \"FN\")<br> (2) references to ImportReference (type = \"IMPORT\")   # noqa: E501

        :param attributes: The attributes of this GrometFNModule.  # noqa: E501
        :type: list[TypedValue]
        """

        self._attributes = attributes

    @property
    def metadata(self):
        """Gets the metadata of this GrometFNModule.  # noqa: E501


        :return: The metadata of this GrometFNModule.  # noqa: E501
        :rtype: Metadata
        """
        return self._metadata

    @metadata.setter
    def metadata(self, metadata):
        """Sets the metadata of this GrometFNModule.


        :param metadata: The metadata of this GrometFNModule.  # noqa: E501
        :type: Metadata
        """

        self._metadata = metadata

    def to_dict(self):
        """Returns the model properties as a dict"""
        result = {}

        for attr, _ in six.iteritems(self.swagger_types):
            value = getattr(self, attr)
            if isinstance(value, list):
                result[attr] = list(map(
                    lambda x: x.to_dict() if hasattr(x, "to_dict") else x,
                    value
                ))
            elif hasattr(value, "to_dict"):
                result[attr] = value.to_dict()
            elif isinstance(value, dict):
                result[attr] = dict(map(
                    lambda item: (item[0], item[1].to_dict())
                    if hasattr(item[1], "to_dict") else item,
                    value.items()
                ))
            else:
                result[attr] = value
        if issubclass(GrometFNModule, dict):
            for key, value in self.items():
                result[key] = value

        return result

    def to_str(self):
        """Returns the string representation of the model"""
        return pprint.pformat(self.to_dict())

    def __repr__(self):
        """For `print` and `pprint`"""
        return self.to_str()

    def __eq__(self, other):
        """Returns true if both objects are equal"""
        if not isinstance(other, GrometFNModule):
            return False

        return self.__dict__ == other.__dict__

    def __ne__(self, other):
        """Returns true if both objects are not equal"""
        return not self == other