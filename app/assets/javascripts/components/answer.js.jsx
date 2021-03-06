var ReactCSSTransitionGroup = React.addons.CSSTransitionGroup;

class Answer extends React.Component {

  constructor(props){
    super(props);
    this.state = {step: 'questions', current: 1, contestant: 0};
    this.choices = this.props.options.slice();
  }

  handleChoose(choice){
    const greater = choice == this.state.current;

    if (!greater && this.state.contestant > 0) {
      this.setState((state) => ({contestant: state.contestant - 1}));
      return;
    }

    const current = this.choices.splice(this.state.current, 1)[0];
    this.choices.splice(this.state.contestant + 1, 0, current);
  
    if (this.state.current + 1 < this.choices.length) {
      this.setState((state) => ({
        current: state.current + 1,
        contestant: state.current,
      }));
    } else {
      this.choices = this.choices.reverse();
      this.setState({step: 'form'})
    }

  }

  handleFormSubmit() {
    this.setState({step: 'result'});
  }

  render(){
    let content;
    if (this.state.step == 'questions') {
      content = this.renderQuestions();
    } else if (this.state.step == 'form') {
      content = this.renderForm();
    } else if (this.state.step == 'result') {
      content = this.renderResult();
    }

    const transitionOptions = {
      transitionName: 'steps',
      transitionEnterTimeout: 2000,
      transitionLeave: false,
      transitionAppear: true,
      transitionAppearTimeout: 1000,
      component: 'div'
    };

    return <ReactCSSTransitionGroup className="answer" {...transitionOptions}>{content}</ReactCSSTransitionGroup>;
  }

  renderQuestions() {
    const option1 = this.choices[this.state.current];
    const option2 = this.choices[this.state.contestant];
    const transitionOptions = {
      transitionName: 'options',
      transitionEnterTimeout: 2000,
      transitionLeaveTimeout: 1000,
      component: 'div'
    };

    return (
      <ReactCSSTransitionGroup key="questions" {...transitionOptions}>
        <Question key={this.state.current+this.state.contestant} id={this.state.current+this.state.contestant} onChoose={this.handleChoose.bind(this)}>
          <Option name={option1.name} imageUrl={option1.image_url} id={this.state.current}/>
          <Option name={option2.name} imageUrl={option2.image_url} id={this.state.contestant}/>
        </Question>
      </ReactCSSTransitionGroup>
    );
  }

  renderForm() {
    return <Form key="form" survey={this.props.survey} choices={this.choices} onSubmit={this.handleFormSubmit.bind(this)} />;
  }

  renderResult(){
    return <Result key="result" survey={this.props.survey} choices={this.choices} />;
  }
}

Answer.propTypes = {
  options: React.PropTypes.arrayOf(React.PropTypes.object),
  survey: React.PropTypes.object,
}