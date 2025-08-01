// generated by codegen, do not edit
import codeql.rust.elements
import TestUtils

query predicate instances(Module x) { toBeTested(x) and not x.isUnknown() }

query predicate getExtendedCanonicalPath(Module x, string getExtendedCanonicalPath) {
  toBeTested(x) and not x.isUnknown() and getExtendedCanonicalPath = x.getExtendedCanonicalPath()
}

query predicate getCrateOrigin(Module x, string getCrateOrigin) {
  toBeTested(x) and not x.isUnknown() and getCrateOrigin = x.getCrateOrigin()
}

query predicate getAttributeMacroExpansion(Module x, MacroItems getAttributeMacroExpansion) {
  toBeTested(x) and
  not x.isUnknown() and
  getAttributeMacroExpansion = x.getAttributeMacroExpansion()
}

query predicate getAttr(Module x, int index, Attr getAttr) {
  toBeTested(x) and not x.isUnknown() and getAttr = x.getAttr(index)
}

query predicate getItemList(Module x, ItemList getItemList) {
  toBeTested(x) and not x.isUnknown() and getItemList = x.getItemList()
}

query predicate getName(Module x, Name getName) {
  toBeTested(x) and not x.isUnknown() and getName = x.getName()
}

query predicate getVisibility(Module x, Visibility getVisibility) {
  toBeTested(x) and not x.isUnknown() and getVisibility = x.getVisibility()
}
