class Form extends React.Component {

  handleSubmit(e) {
    const data = {
      answer: {
        survey_id: this.props.survey.id,
        choices_attributes: this.props.choices.map((option) => ({chosen_id: option.id})),
        user_attributes: $(e.currentTarget).serializeObject()
      }
    };

    $.post('/answers.json', data)
     .done(() => { this.props.onSubmit() })
     .fail(() => { console.log(data) })

    e.preventDefault();
  }

  render() {
    return (
      <div className="form">
        <form onSubmit={this.handleSubmit.bind(this)}>
          <h2>{I18n.t('fill_to_see_your_result')}</h2>
          <div className="form-group">
            <label htmlFor="name">{I18n.t('name')}</label>
            <input type="text" name="name" className="form-control" id="name" placeholder={I18n.t('name')}/>
          </div>
          <div className="form-group">
            <label htmlFor="email">{I18n.t('email')}</label>
            <input type="email" name="email" className="form-control" id="email" placeholder={I18n.t('email')}/>
          </div>
          <button type="submit" className="btn btn-info btn-block">{I18n.t('show_result')}</button>
        </form>
      </div>
    );
  }
}

Form.propTypes = {
  choices: React.PropTypes.arrayOf(React.PropTypes.object),
  survey: React.PropTypes.object,
  onSubmit: React.PropTypes.func,
}