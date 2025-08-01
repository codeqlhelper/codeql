// generated by codegen, do not edit
import codeql.rust.elements
import TestUtils

query predicate instances(FormatArgsExpr x) { toBeTested(x) and not x.isUnknown() }

query predicate getArg(FormatArgsExpr x, int index, FormatArgsArg getArg) {
  toBeTested(x) and not x.isUnknown() and getArg = x.getArg(index)
}

query predicate getAttr(FormatArgsExpr x, int index, Attr getAttr) {
  toBeTested(x) and not x.isUnknown() and getAttr = x.getAttr(index)
}

query predicate getTemplate(FormatArgsExpr x, Expr getTemplate) {
  toBeTested(x) and not x.isUnknown() and getTemplate = x.getTemplate()
}

query predicate getFormat(FormatArgsExpr x, int index, Format getFormat) {
  toBeTested(x) and not x.isUnknown() and getFormat = x.getFormat(index)
}
