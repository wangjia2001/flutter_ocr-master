class jump {
  // String thisid;
  //需求单id
  String id;
  //需求单是否被接受
  String yorn;
  //person id
  String personid;

  jump(String personid, String id, String yorn) {
    // this.thisid = thisid; //需求单序号
    this.personid = personid;
    this.id = id; //需求单真实id
    this.yorn = yorn;
  }
}
