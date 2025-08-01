// generated by codegen/codegen.py, do not edit
import codeql.swift.elements
import TestUtils

query predicate instances(
  ParamDecl x, string getModule__label, ModuleDecl getModule, string getInterfaceType__label,
  Type getInterfaceType, string getName__label, string getName, string getType__label, Type getType,
  string isInout__label, string isInout
) {
  toBeTested(x) and
  not x.isUnknown() and
  getModule__label = "getModule:" and
  getModule = x.getModule() and
  getInterfaceType__label = "getInterfaceType:" and
  getInterfaceType = x.getInterfaceType() and
  getName__label = "getName:" and
  getName = x.getName() and
  getType__label = "getType:" and
  getType = x.getType() and
  isInout__label = "isInout:" and
  if x.isInout() then isInout = "yes" else isInout = "no"
}

query predicate getMember(ParamDecl x, int index, Decl getMember) {
  toBeTested(x) and not x.isUnknown() and getMember = x.getMember(index)
}

query predicate getAccessor(ParamDecl x, int index, Accessor getAccessor) {
  toBeTested(x) and not x.isUnknown() and getAccessor = x.getAccessor(index)
}

query predicate getAttachedPropertyWrapperType(ParamDecl x, Type getAttachedPropertyWrapperType) {
  toBeTested(x) and
  not x.isUnknown() and
  getAttachedPropertyWrapperType = x.getAttachedPropertyWrapperType()
}

query predicate getParentPattern(ParamDecl x, Pattern getParentPattern) {
  toBeTested(x) and not x.isUnknown() and getParentPattern = x.getParentPattern()
}

query predicate getParentInitializer(ParamDecl x, Expr getParentInitializer) {
  toBeTested(x) and not x.isUnknown() and getParentInitializer = x.getParentInitializer()
}

query predicate getPropertyWrapperBackingVarBinding(
  ParamDecl x, PatternBindingDecl getPropertyWrapperBackingVarBinding
) {
  toBeTested(x) and
  not x.isUnknown() and
  getPropertyWrapperBackingVarBinding = x.getPropertyWrapperBackingVarBinding()
}

query predicate getPropertyWrapperBackingVar(ParamDecl x, VarDecl getPropertyWrapperBackingVar) {
  toBeTested(x) and
  not x.isUnknown() and
  getPropertyWrapperBackingVar = x.getPropertyWrapperBackingVar()
}

query predicate getPropertyWrapperProjectionVarBinding(
  ParamDecl x, PatternBindingDecl getPropertyWrapperProjectionVarBinding
) {
  toBeTested(x) and
  not x.isUnknown() and
  getPropertyWrapperProjectionVarBinding = x.getPropertyWrapperProjectionVarBinding()
}

query predicate getPropertyWrapperProjectionVar(ParamDecl x, VarDecl getPropertyWrapperProjectionVar) {
  toBeTested(x) and
  not x.isUnknown() and
  getPropertyWrapperProjectionVar = x.getPropertyWrapperProjectionVar()
}

query predicate getPropertyWrapperLocalWrappedVarBinding(
  ParamDecl x, PatternBindingDecl getPropertyWrapperLocalWrappedVarBinding
) {
  toBeTested(x) and
  not x.isUnknown() and
  getPropertyWrapperLocalWrappedVarBinding = x.getPropertyWrapperLocalWrappedVarBinding()
}

query predicate getPropertyWrapperLocalWrappedVar(
  ParamDecl x, VarDecl getPropertyWrapperLocalWrappedVar
) {
  toBeTested(x) and
  not x.isUnknown() and
  getPropertyWrapperLocalWrappedVar = x.getPropertyWrapperLocalWrappedVar()
}
