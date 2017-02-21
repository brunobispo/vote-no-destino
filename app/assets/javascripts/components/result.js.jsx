class Result extends React.Component {

  constructor(props) {
    super(props);
    this.state = {globalChoices: null}
    this.loadGlobalChoices();
  }

  loadGlobalChoices(){
    const url = '/surveys/' + this.props.survey.id + '.json';
    $.get(url)
      .done((result) => {
        const globalChoices = result.options.sort((a,b) => b.score - a.score);
        this.setState({globalChoices: globalChoices})
      })
      .fail(() => console.log(data));
  }

  render() {
    return (
      <div className="result">
        <div className="your_ranking">
          <div className="alert alert-info">{I18n.t('registration_successful')}</div>
          <h2><i className="fa fa-star-half-o"/> {I18n.t('your_ranking')}</h2>
          {this.renderLocalChoices()}
          <h2><i className="fa fa-globe"/> {I18n.t('general_ranking')}</h2>
          {this.renderGlobalChoices()}
        </div>
      </div>
    );
  }

  renderLocalChoices() {
    return (
      <ol>
        {this.props.choices.map((choice, key) => <li key={key}>{choice.name}</li>)}
      </ol>
    );
  }

  renderGlobalChoices() {
    if (!this.state.globalChoices) {
      return <p>{I18n.t('loading')}</p>;
    } else {
      return (
        <ol>
          {this.state.globalChoices.map((choice, key) => <li key={key}>{choice.name}</li>)}
        </ol>
      );
    }
  }
}

Result.propTypes = {
  choices: React.PropTypes.arrayOf(React.PropTypes.object),
  survey: React.PropTypes.object,
}