package beans;

import java.util.ArrayList;
import java.util.List;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;

import controller.ControlaEvento;
import model.Pais;

@ManagedBean
@ViewScoped
public class PaisBeans {
	
	private Pais pais = new Pais();
	private List<Pais> listaPais = new ArrayList<>();
	private ControlaEvento cd = new ControlaEvento();
	
	public Pais getPais() {
		return pais;
	}
	public void setPais(Pais pais) {
		this.pais = pais;
	}
	public List<Pais> getListaPais() {
		return listaPais;
	}
	public void setListaPais(List<Pais> listaPais) {
		this.listaPais = listaPais;
	}

}
