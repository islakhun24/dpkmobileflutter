// ignore_for_file: constant_identifier_names

class Url {
  // static const BASE_URL = "http://localhost:8080/api";
  static const BASE_URL = "https://regulated-agen-backend.herokuapp.com/api";
  static const LOGIN = "$BASE_URL/auth/signin";
  static const ACCEPTANCE_PROJECT_GET = "$BASE_URL/main2/projek/acceptance";
  static const ACCEPTANCE_SMU_LIST = "$BASE_URL/main2/smu/list";
  static const ACCEPTANCE_SUGGEST_SMU = "$BASE_URL/main2/suggestion/smu";
  static const ACCEPTANCE_SUGGEST_CUSTOMER = "$BASE_URL/main2/suggestion/customer";
  static const ACCEPTANCE_SUGGEST_BARANG = "$BASE_URL/main2/suggestion/barang";
  static const ACCEPTANCE_SELESAI = "$BASE_URL/main2/projek/acceptance/selesai";
  static const ACCEPTANCE_SMU_CREATE = "$BASE_URL/main2/smu/create";
  static const ACCEPTANCE_DETAIL_SMU_SUGGEST = "$BASE_URL/mobile/acceptance/detail/smu";
  static const ACCEPTANCE_DETAIL_AGEN = "$BASE_URL/mobile/acceptance/detail/agen";
  static const ACCEPTANCE_SMU_SELESAI ="$BASE_URL/main2/projek/acceptance/selesai";
  static const CHECKER_SMU_PROJECT = "$BASE_URL/main2/checker/get";
  static const CHECKER_SMU_LIST = "$BASE_URL/mobile/checker/smu/list";
  static const CHECKER_SMU_UPDATE = "$BASE_URL/mobile/checker/update/smu";
  static const DOCUMENT_CHECKER_DETAIL = "$BASE_URL/main2/checker/document";
  static const DOCUMENT_SMU_DETAIL = "$BASE_URL/main2/document/smu4";
  static const CSD_CREATE = "$BASE_URL/revisi/document/create";
}
