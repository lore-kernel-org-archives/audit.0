Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150F416DC13
	for <audit@vger.kernel.org>; Mon,  5 Aug 2024 21:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722893324; cv=none; b=a8Hee4MXH4Tk4/VG0tIcRYMMKKz9psIjq4eHRKDTc0pt+2cFlrtaQFK/tnCg0A1o/pwJdQiDkaVDRAd3hge9/yZvbbThkoMijEXQjiU0ldj0gEK/zEwve6Is5YdUg5TphMiu4F5bnOAfBt0kSzsZlF97Vt4V5HcRR+jdppoWYTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722893324; c=relaxed/simple;
	bh=CTTjcSVZh00GG8bK8bn079xIUwIcu3ks1xC9HUn/WHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZnX65Hnqii4fmT82UCO9erH1tMiKRsDk6FSI3nGZJ8vQwcmX9UutA/FXAQ1avKD1GkSBxcgCnYStzR4Tplt2o8Y6tTYONXQ/q+IClaHtb8UcZEuMK9MbuDeno7wWsGfBg8YjyV610agfeWceNUuJH6qgDARhY2/fQ7UD3i4fQX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Z3WL/weh; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z3WL/weh"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52f0277daa5so17075566e87.0
        for <audit@vger.kernel.org>; Mon, 05 Aug 2024 14:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722893321; x=1723498121; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4JmhoGoeqp0EkHzxnqjsByi1+fgV+qGizB/Udaf1KjI=;
        b=Z3WL/wehUA5oHx3YiNUr8peqdqJXXgq+u0kf/MCKZGVY29llW5P9dlZLF8LCL+bnGe
         OrxAmsczeLx2sKEdHBpzdD0FVhnhPnYYOFnTRAur5Sq6vFbyLYR1pspKrM36I7MnHaSq
         opiT21XaeDREo7lFKx+kdwZ6CQlW4dBqbihzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722893321; x=1723498121;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4JmhoGoeqp0EkHzxnqjsByi1+fgV+qGizB/Udaf1KjI=;
        b=HiNQve2+hi2hJRAxh8B+e6MvPRzMR6QxseReJJQ1yWSXIeRViwQbPTtmVPw2KhvpZj
         yH9JA2vXQ2GvP+eJ3V0hUmUUVAAhBd0PmntuQCYAKYFqw0FQxaR6nGPteu7Mmcn6nCvy
         7sdtOS+mN3gxlI0vjb8rvcqzyLCTlIlSk6qF/odGBj+V6LPvv/XaBCY3FOoWC0YN3kbn
         pd24l+BACkvVr5OQ4FGl7b1uZvzIDRMNyjs/I3mSiKtbivdlP0zbNl7b/el8HXNNqE58
         OmdRouWyhUSafHIq3usFcUNeugYb7NJsqvqm24NgKJHsqHmZj3Bd3wI+Nq79jmyTYfWM
         c1Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUjeT3eyJg1TjtBE7GYwPPDHOpZB/4qPATvAUM4BMpS5pSxLWl/sVeHfRRAv6Fkz2TgA2E6Sim5urROPSqII0zogYV1tZU=
X-Gm-Message-State: AOJu0YyOaG1iOsKKG7bPngdkal2hoZ3UJDLd1yCPbqPv4zVUNMrqz/Ap
	ZXSnzbFLbP7wgpGVoXPl8Y3c2ZwYK2U3d+Gvs/mz7kRKf4wqdzenbw8ZxrYUfPGVObQj77XOgdu
	hUZB9uw==
X-Google-Smtp-Source: AGHT+IGfGIMTfhbX+a8b0LLo0+HAnh/wvQ1k06UK/9DXxWQTmlfM6WZGtpoZzqPkwYOiMnxNm+H+SQ==
X-Received: by 2002:a05:6512:128e:b0:52c:d9b3:2b06 with SMTP id 2adb3069b0e04-530bb3b31damr8892703e87.58.1722893320924;
        Mon, 05 Aug 2024 14:28:40 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e83e50sm497431866b.172.2024.08.05.14.28.39
        for <audit@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 14:28:39 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a2a90243c9so12616763a12.0
        for <audit@vger.kernel.org>; Mon, 05 Aug 2024 14:28:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXdi1VNlTeWDdc+aTVx5OJPLLZmFwPTTf3XAAkk5nf1mWqbpfSMM7Tvwke8xfcH64PPh65xT17SMNDTCjlKiU8ENPG2bk8=
X-Received: by 2002:aa7:df97:0:b0:5af:758a:6934 with SMTP id
 4fb4d7f45d1cf-5b7f0fc7f1amr8956337a12.0.1722893319128; Mon, 05 Aug 2024
 14:28:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804075619.20804-1-laoar.shao@gmail.com>
In-Reply-To: <20240804075619.20804-1-laoar.shao@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Aug 2024 14:28:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whWtUC-AjmGJveAETKOMeMFSTwKwu99v7+b6AyHMmaDFA@mail.gmail.com>
Message-ID: <CAHk-=whWtUC-AjmGJveAETKOMeMFSTwKwu99v7+b6AyHMmaDFA@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Improve the copy of task comm
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, ebiederm@xmission.com, 
	alexei.starovoitov@gmail.com, rostedt@goodmis.org, catalin.marinas@arm.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 Aug 2024 at 00:56, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> There is a BUILD_BUG_ON() inside get_task_comm(), so when you use
> get_task_comm(), it implies that the BUILD_BUG_ON() is necessary.

Let's just remove that silly BUILD_BUG_ON(). I don't think it adds any
value, and honestly, it really only makes this patch-series uglier
when reasonable uses suddenly pointlessly need that double-underscore
version..

So let's aim at

 (a) documenting that the last byte in 'tsk->comm{}' is always
guaranteed to be NUL, so that the thing can always just be treated as
a string. Yes, it may change under us, but as long as we know there is
always a stable NUL there *somewhere*, we really really don't care.

 (b) removing __get_task_comm() entirely, and replacing it with a
plain 'str*cpy*()' functions

The whole (a) thing is a requirement anyway, since the *bulk* of
tsk->comm really just seems to be various '%s' things in printk
strings etc.

And once we just admit that we can use the string functions, all the
get_task_comm() stuff is just unnecessary.

And yes, some people may want to use the strscpy_pad() function
because they want to fill the whole destination buffer. But that's
entirely about the *destination* use, not the tsk->comm[] source, so
it has nothing to do with any kind of "get_task_comm()" logic, and it
was always wrong to care about the buffer sizes magically matching.

Hmm?

                Linus
