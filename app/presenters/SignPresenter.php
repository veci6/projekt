<?php

namespace App\Presenters;

use App\Forms\SignFormFactory;
use Nette\Application\UI\Form;

/**
 * Presenter pro registraci uživatelů.
 * @package App\Presenters
 */
class SignPresenter extends BasePresenter {

    /**
     * @var SignFormFactory Továrnička pro tvorbu registračního
      formuláře.
     * @inject
     */
    public $formFactory;

    /**
     * Vytváří a vrací komponentu registračního formuláře.
     * @return Form komponenta registračního formuláře
     */
    protected function createComponentSignUpForm() {
        $form = $this->formFactory->createSignUp();
        $form->onSuccess[] = function (Form $form) {
            $p = $form->getPresenter();
            $p->flashMessage($this->translator->translate("sign.youWereSignedUp"));
            $p->redirect("this");
        };
        return $form;
    }

}
