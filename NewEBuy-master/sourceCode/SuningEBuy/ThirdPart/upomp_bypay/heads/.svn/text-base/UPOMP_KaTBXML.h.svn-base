//
//  KaXML.h
//  mylibs
//
//  Created by pei xunjun on 11-11-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UPOMP_MAX_ELEMENTS 100
#define UPOMP_MAX_ATTRIBUTES 100

#define UPOMP_TBXML_ATTRIBUTE_NAME_START 0
#define UPOMP_TBXML_ATTRIBUTE_NAME_END 1
#define UPOMP_TBXML_ATTRIBUTE_VALUE_START 2
#define UPOMP_TBXML_ATTRIBUTE_VALUE_END 3
#define UPOMP_TBXML_ATTRIBUTE_CDATA_END 4

typedef struct _UPOMP_TBXMLAttribute {
	char * name;
	char * value;
	struct _UPOMP_TBXMLAttribute * next;
} UPOMP_TBXMLAttribute;

typedef struct _UPOMP_TBXMLElement {
	char * name;
	char * text;
	UPOMP_TBXMLAttribute * firstAttribute;
	struct _UPOMP_TBXMLElement * parentElement;
	struct _UPOMP_TBXMLElement * firstChild;
	struct _UPOMP_TBXMLElement * currentChild;
	struct _UPOMP_TBXMLElement * nextSibling;
	struct _UPOMP_TBXMLElement * previousSibling;
} UPOMP_TBXMLElement;

typedef struct _UPOMP_TBXMLElementBuffer {
	UPOMP_TBXMLElement * elements;
	struct _UPOMP_TBXMLElementBuffer * next;
	struct _UPOMP_TBXMLElementBuffer * previous;
} UPOMP_TBXMLElementBuffer;

typedef struct _UPOMP_TBXMLAttributeBuffer {
	UPOMP_TBXMLAttribute * attributes;
	struct _UPOMP_TBXMLAttributeBuffer * next;
	struct _UPOMP_TBXMLAttributeBuffer * previous;
} UPOMP_TBXMLAttributeBuffer;


@interface UPOMP_KaTBXML : NSObject {
	UPOMP_TBXMLElement * rootXMLElement;
	UPOMP_TBXMLElementBuffer * currentElementBuffer;
	UPOMP_TBXMLAttributeBuffer * currentAttributeBuffer;
	long currentElement;
	long currentAttribute;
	char * bytes;
	long bytesLength;
}
- (id)initWithXMLData:(NSData*)aData;
- (NSString*) elementName:(UPOMP_TBXMLElement*)aXMLElement;
- (NSString*) textForElement:(UPOMP_TBXMLElement*)aXMLElement;
- (NSString*) valueOfAttributeNamed:(NSString *)aName forElement:(UPOMP_TBXMLElement*)aXMLElement;

- (UPOMP_TBXMLElement*) getRootXMLElement;
- (UPOMP_TBXMLElement*) nextSiblingNamed:(NSString*)aName searchFromElement:(UPOMP_TBXMLElement*)aXMLElement;
- (UPOMP_TBXMLElement*) childElementNamed:(NSString*)aName parentElement:(UPOMP_TBXMLElement*)aParentXMLElement;

@end
