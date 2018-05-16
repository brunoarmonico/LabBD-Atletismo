package beans;

import java.util.ArrayList;
import java.util.List;

import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;

import controller.ControlaEvento;
import model.Prova;

@ManagedBean
@ViewScoped
public class ProvaBeans {
	private Prova prova = new Prova();
	private List<Prova> listaProvas = new ArrayList<>();
	private ControlaEvento cd = new ControlaEvento();

	public Prova getProva() {
		return prova;
	}

	public void setProva(Prova prova) {
		this.prova = prova;
	}

	public List<Prova> getListaProvas() {
		recebeProvas();
		return listaProvas;
	}

	public void setListaProvas(List<Prova> listaProvas) {
		this.listaProvas = listaProvas;
	}

	private void recebeProvas() {
		if (listaProvas.isEmpty() == true) {
			listaProvas = cd.listarProvas();
		}
	}
}
