/**
 * @name Some query
 * @description Some description
 * @kind problem
 * @problem.severity warning
 * @precision very-high
 * @id ql/quality-query-test
 * @tags quality
 *       maintainability
 *       reliability
 */

import ql

from Class c
where none()
select c, ""
