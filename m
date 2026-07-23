Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8672B340A7D
	for <audit@vger.kernel.org>; Thu, 23 Jul 2026 22:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784845654; cv=pass; b=ZcHLhnuQqRlgIfJfPTtNQ/Cn7Ug7fB7UOihe9gHULfjFN64Im0JuAjflwAN2o0eJ4KSt8Y9sPSD2DlOiy61fopZ1HuYmBr/1Mf97leprJ4XJoF1USVJpE/XSqLxiMBaaV/DBB+cd/n0Y6Z6YUPw/dC92JSnPrBqh579VtdfOZsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784845654; c=relaxed/simple;
	bh=t0iUBzevmFveCd0WmRF/lxamd1vVW3VdDoxBu57bxEQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=QrTvK8sNeoaZ8IJSlbk95BOH7zvn8PDuepc4D+BvCyXOycFLL/mZXoeIVeK2g5lgToIJv83gP4K/86IeZ1FrssZkSUoezc5U4Pe38OAiahNNi/EEQHk/quGz1PctytsIkfwAPQnu9+mO2bqFiQcxDw0EWwq12D/KPxDbkXK9ps4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=T5ZXVAct; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="T5ZXVAct"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ceae1ed204so12141645ad.0
        for <audit@vger.kernel.org>; Thu, 23 Jul 2026 15:27:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784845645; cv=none;
        d=google.com; s=arc-20260327;
        b=J7Jct3y1m+hjROa2z7KlrzpG9Of4OjJdeAlSzlxrZNrCuFb1uwQTJpQFIuekH2AMQb
         9m/A8ZAGzr0O4zFnNgOFjclvWz4RqiBBRmDPHhreKdImegdzMI4EHJZA/G7A5Z9oBp4V
         BxOwpRcvjV9TDVspIn/90VSSq4L4HfQOZ5Ku6Kn0kHQ3Z54GLH5eCtVjjOPGPkD8b5W+
         hqUFk45DBL271ecvuirSdukPnZWdYhzh6DCmgtKOG4XFfK3ABU12vTHpKMMr2s20bJVh
         H0VgxUBtYHhCEVxBMMK2ve/BMasBmx5VBbNI60jkrypJ4Fk+NChnDSsPrOY53EJT8l6T
         /X4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=QWDiYtSQLZRUr8v0S9quVez7nXU1TVaCE7sRceo2Xr0=;
        fh=oBw5EyoXL0ZfKfXM8/u8cmypyz64HqmLvuAh8viE4cE=;
        b=kVd3MJxdyE/fvPUTNWCvJfh4PWD1t0gMCdkX4WxASTbpmNppEQaBfUsC3jhXQOpsI3
         h810TD7lAJeC1sZ8IokFwIC9M69N5uuQ7btbRtWgv4AXAazSla7lIJT39cvdoYEXTwf1
         COgOLjbR/s7R7NL7/sH4XfhKHUlD+jCS7zqWc9Lgn2LWncTtXJtSa6IW93UC9BHoaFKR
         kwoBdTXb5z65fNIKOZ6Fxb3sdrUhwVFFyJ7+ChQlCGng0siCMcW+c7A3Hpdvh/AfbGgT
         cXZ46+zgQiG4HMpiGnQKufEySrSDeZbkXajmyam9xINAOuXta9TUi7nJamsbQfzcocL+
         jcQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784845645; x=1785450445; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QWDiYtSQLZRUr8v0S9quVez7nXU1TVaCE7sRceo2Xr0=;
        b=T5ZXVActfhKkNDME0Dszng0WPgRuWJj/EL5XiiWnIpf3o0Bid3LSaJgJDnRaIveRC2
         7/K5KPQuBQK3lurf0A9EL9HyKI6p3BbCg0GuMkdlUcFX5FlNXNtpgvDXsYlQncc1G9Ss
         HmcQTd9YCcJcCatIx5Lewzmz5L3eqRkHjbPQP7i8yNuLleXuPXP/lKIxA8mIy3vKLs3h
         ddvB/EWVqNP270iYp2TzfVp1bzEhqHYiVvL+T8S/J0gwwjdMoYftJtEFFSeACVKxvLzc
         xXIyIkdKKd3vHJ3E0TOrjzzzvjWZrIAMOoNu5ZzkK0MrLRBhVNwJLiRmsRCUBPqzMf9V
         aLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784845645; x=1785450445;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QWDiYtSQLZRUr8v0S9quVez7nXU1TVaCE7sRceo2Xr0=;
        b=mYbotPxoouM6F8q69skl0nSBITLrYLvoRU0G2uHGNui13A/cTzvk8pHn6al0CKsNSx
         9MszTh0wQJ1QdJhie17QCTo7/8ZgNC+Irh359+pyprnK+FxGw9SRYhwAmz3vU4/Kn4+P
         Fon1SXByE7OT8FD9ZH+ZZEXjKh4psbjFfUcfzxVXAfNH3BUoIz51vUgVXkGin+VYUzWn
         fwfAlzGPm/Omj0vx/9mqHKGhIO81BBJWu0wdsVEin9ES7JUsjEz3fpQ0njjAdE+DxvIe
         J/YL4gAvmp7JAFNMnxno/mgm6YdHgjmyKSQKGHMEC44IArKb+0js3auoallFKG7Ljob+
         g3jw==
X-Gm-Message-State: AOJu0YxUMMFftEIuyy73pDVppeE5yZlC5+p8w9W7b/aN8xC7PNMWUmSh
	3aSoZv+9AsS7YePJr67G7I7fljyWOYqz6IA/be+566czLcx0WJOX8S006DXbZ6rr1pl2WqK5hu+
	L0z3gcHZjuzpFnixC4CI7x5YOOc8NEvq42aCM5aMogGEP5G9UeasAo0iK
X-Gm-Gg: AR+sD10G6PzjiM+g46X/8ISk+KkY7nsA3SWksZv7towf5BncxkHeusK+9qlSkmoa6dP
	/eE1FNjeqdm5e3ZLNADCXInM2SOlmQCgPDNSbBxWwbfYHdT6/ltPEHnq5KS7VJzjYP8vox6yhok
	dO298T9hFvS5qEmmGhY4Z8AgElYLM3BwYuDc3u+fN6LG9j5VwXQ5LqC1FvQXI35E1pEAjTUtUqD
	dODzHmWU4yXM/T/erMV8JRw+wG+RsRW9o4p220xZNhO5CVbbCuiUKkUbXVSGQ==
X-Received: by 2002:a17:902:f70b:b0:2ca:eea:eb5c with SMTP id
 d9443c01a7336-2cfa6b775f5mr53334765ad.18.1784845644624; Thu, 23 Jul 2026
 15:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 23 Jul 2026 18:27:12 -0400
X-Gm-Features: AUfX_myk6q4mqSuZvmuPIjOaYmNZe7-LXYwttLtriuhYvBIm4SZoPBu0NA7MO_Q
Message-ID: <CAHC9VhT5pLSGx=-QzA5P6xiHgEPmgZfy4eURe8SQR40d6Qt7Mw@mail.gmail.com>
Subject: Enable sashiko.dev for the audit list?
To: audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello all,

By now, I suspect everyone reading this knows about the Sashiko.  For
those who do not know, Sashiko is an LLM review bot for kernel patches
that leverages Chris Mason's LLM prompts to automatically review
patches posted to enabled mailing lists and optionally provide an
email reply with feedback.  You can get an idea of the type of
feedback it provides via the web UI at the URL below:

 https://sashiko.dev

I'd like to enable Sashiko for the audit@vger mailing list and allow
it to send feedback to the list (and only to the list, we could expand
it to the submitter later), are there any objections?  Alternatively,
we could simply enable Sashiko for the audit list but keep the
automated email disabled.  While less convenient, the feedback would
still be visible on the web UI.

Thoughts?

-- 
paul-moore.com
