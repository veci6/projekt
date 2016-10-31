<?php

namespace App\Forms;

use App\Model\Entities\User as UserEntity;
use App\Model\Facades\UserFacade;
use Doctrine\DBAL\Exception\UniqueConstraintViolationException;
use Kdyby\Translation\Translator;
use Nette\Application\UI\Form;
use Nette\Object;
use Nette\Security\AuthenticationException;
use Nette\Utils\ArrayHash;

/**
 * Továrnička pro tvorbu registračního formuláře.
 * @package App\Forms
 */
class SignFormFactory extends Object {

    /** @var UserFacade Fasáda pro práci s uživateli. */
    private $userFacade;

    /** @var Translator Překladač. */
    private $translator;

    /**
     * Konstruktor s injektovanou fasádou pro práci s uživateli a
      překladačem.
     * @param UserFacade $userFacade automaticky injektovaná fasáda pro
      práci s uživateli
     * @param Translator $translator automaticky injektovaný překladač
     */
    public function __construct(UserFacade $userFacade, Translator
    $translator) {
        $this->userFacade = $userFacade;
        $this->translator = $translator;
    }

    /**
     * Vytváří a vrací komponentu registračního formuláře.
     * @return Form registrační formulář
     */
   public function createSignUp()
	{
		$form = new Form;
		$form->addText("name", $this->translator->translate("form.sign.up.name"))
			->setRequired($this->translator->translate("form.sign.up.nameNotFilled"))
			->addRule(Form::MAX_LENGTH, $this->translator->translate("form.sign.up.nameMayHaveMaxLetters"), UserEntity::MAX_NAME_LENGTH)
			->addRule(Form::PATTERN, $this->translator->translate("common.userNameBadFormat"), UserEntity::NAME_FORMAT);

		$form->addPassword("password", $this->translator->translate("form.sign.up.password"))
			->setRequired($this->translator->translate("form.sign.up.passwordNotFilled"));

		$form->addText("email", $this->translator->translate("form.sign.up.email"))
			->setRequired($this->translator->translate("form.sign.up.emailNotFilled"))
			->addRule(Form::EMAIL, $this->translator->translate("form.sign.up.emailBadFormat"));

		$form->addSubmit("signUp", $this->translator->translate("form.sign.up.signUp"));

		$form->onSuccess[] = array($this, "signUpSubmitted");

		return $form;
	}

	/**
	 * Funkce se vykoná při uspěšném odeslání formuláře pro registraci a pokusí se registrovat nového uživatele.
	 * @param Form $form        formulář pro registraci
	 * @param ArrayHash $values odeslané hodnoty formuláře
	 */
	public function signUpSubmitted($form, $values)
	{
		try {
			$values->ip = $form->getPresenter()->context->getService("httpRequest")->getRemoteAddress();
			$this->userFacade->registerUser($values);
		} catch (AuthenticationException $e) {
			$form->addError($e->getMessage());
		} catch (UniqueConstraintViolationException $e) {
			$form->addError($this->translator->translate("form.sign.up.userWithThisNameAlreadyExists"));
		}
	}


}
