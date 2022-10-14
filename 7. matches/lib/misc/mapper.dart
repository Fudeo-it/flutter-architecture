abstract class DTOMapper<D, M> {
  M toModel(D dto);

  D toTransferObject(M model);
}
