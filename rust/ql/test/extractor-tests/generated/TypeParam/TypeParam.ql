// generated by codegen, do not edit
import codeql.rust.elements
import TestUtils

query predicate instances(TypeParam x) { toBeTested(x) and not x.isUnknown() }

query predicate getAttr(TypeParam x, int index, Attr getAttr) {
  toBeTested(x) and not x.isUnknown() and getAttr = x.getAttr(index)
}

query predicate getDefaultType(TypeParam x, TypeRepr getDefaultType) {
  toBeTested(x) and not x.isUnknown() and getDefaultType = x.getDefaultType()
}

query predicate getName(TypeParam x, Name getName) {
  toBeTested(x) and not x.isUnknown() and getName = x.getName()
}

query predicate getTypeBoundList(TypeParam x, TypeBoundList getTypeBoundList) {
  toBeTested(x) and not x.isUnknown() and getTypeBoundList = x.getTypeBoundList()
}
