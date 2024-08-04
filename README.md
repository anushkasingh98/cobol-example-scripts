## cobol-example-scripts




## Purpose

This codebase implements a comprehensive test suite for COBOL compiler conformance, focusing on inter-program communication features such as CALL statements, parameter passing, and subprogram interactions. It tests various aspects of COBOL including file handling, data structures, and program flow control across multiple interconnected programs.

## Overview of Files

| File | Summary |
|------|---------|
| IC101A.CBL | Main program testing CALL statement with one parameter |
| IC102A.CBL | Subprogram called by IC101A, modifies passed parameter |
| IC103A.CBL | Tests multiple EXIT PROGRAM statements and parameter passing |
| IC104A.CBL | Subprogram for testing parameter passing |
| IC105A.CBL | Subprogram with multiple EXIT PROGRAM statements |
| IC106A.CBL | Tests index data items and table operations in subprograms |
| IC107A.CBL | Subprogram for table and index operations |
| IC108A.CBL | Tests sequence of subprogram calls and parameter passing |
| IC109A.CBL | First subprogram in a chain of calls |
| IC110A.CBL | Second subprogram in a chain of calls |
| IC111A.CBL | Third subprogram in a chain of calls |
| IC112A.CBL | Tests file operations and subprogram calls for file handling |
| IC113A.CBL | Subprogram for file record validation |
| IC114A.CBL | Tests file creation and validation through subprogram calls |
| IC115A.CBL | Subprogram for file operations called by IC114A |
| IC116M.CBL | Tests CALL statement without USING phrase |
| IC117M.CBL | Subprogram called by IC116M, demonstrates program flow |
| IC118M.CBL | Subprogram called by IC117M, further demonstrates program flow |
| IC201A.CBL | Tests various CALL statement features and parameter passing |
| IC202A.CBL | Subprogram for testing parameter modifications |
| IC203A.CBL | Tests CALL and CANCEL statements with multiple subprograms |
| IC204A.CBL | Subprogram tracking call count and initial state |
| IC205A.CBL | Tests subprogram calls and CANCEL statement |
| IC206A.CBL | Subprogram incrementing a counter on each call |
| IC207A.CBL | Tests variable-length tables and condition names in subprograms |
| IC208A.CBL | Subprogram for table operations and condition name testing |
| IC209A.CBL | Tests nested subprogram calls and CANCEL statement |
| IC210A.CBL | First level subprogram in nested call structure |
| IC211A.CBL | Second level subprogram in nested call structure |
| IC212A.CBL | Third level subprogram in nested call structure |
| IC213A.CBL | Tests CALL and CANCEL with multiple subprograms |
| IC214A.CBL | Subprogram modifying a single parameter |
| IC215A.CBL | Subprogram demonstrating CANCEL of another program |
| IC216A.CBL | Tests parameter passing with group items |
| IC217A.CBL | Subprogram modifying group item parameters |
| IC222A.CBL | Subprogram incrementing and modifying parameters |
| IC223A.CBL | Similar to IC222A, with slight variations |
| IC224A.CBL | Tests various CALL statement features and parameter handling |
| IC225A.CBL | Tests CALL with BY REFERENCE and BY CONTENT |
| IC226A.CBL | Tests external data items across programs |
| IC227A.CBL | Subprogram for external file operations |
| IC228A.CBL | Tests global data items across programs |
| IC233A.CBL | Tests USE procedures with nested programs |
| IC234A.CBL | Tests USE procedures across multiple levels of nested programs |
| IC235A.CBL | Tests complex parameter passing and multiple EXIT PROGRAM statements |
| IC237A.CBL | Tests Linkage Section items in subprogram calls |
| IC401M.CBL |

