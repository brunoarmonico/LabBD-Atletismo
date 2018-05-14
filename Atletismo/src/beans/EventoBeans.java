package beans;

import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;

import model.Atleta;
import model.Resultado;
import persistence.DBEvento;

@ManagedBean
@ViewScoped
public class EventoBeans {
	private Atleta atleta = new Atleta();
	private Resultado resultado = new Resultado();
	private DBEvento bd = new DBEvento();
	

	public Atleta getAtleta() {
		return atleta;
	}

	public void setAtleta(Atleta atleta) {
		this.atleta = atleta;
	}

	public Resultado getResultado() {
		return resultado;
	}

	public void setResultado(Resultado resultado) {
		this.resultado = resultado;
	}

	public void adicionarAtleta() {
		String retorno = bd.novoAtleta(atleta);
		if (retorno != null) {
			FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(retorno));
		}
	}
}
