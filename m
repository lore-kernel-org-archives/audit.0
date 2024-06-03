Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B73713C918
	for <audit@vger.kernel.org>; Mon,  3 Jun 2024 22:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717453450; cv=none; b=pkhQHvoPTDSq9KHbc3XjHZy/VcFUUMoVjOZF4aT+YexakRfvtzz9TO71om5orLxQHTGu6WfpYP/yRqlpjcuHtpX9vEHwD9egluyPveTC8wxtk/1Gp5J2i5T3s7dhRU+WoJ147TLmRGNm3YCOZpHkNc0Xx7YnsWxrX9+C3OKL9w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717453450; c=relaxed/simple;
	bh=AFfU/PEC+zuhNdQ2tMeUL2Lz6Nhx2hQNDlZEumLFtHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DCWp3SsjT/MIaeIkKoIBJpGPShTSfArdaDgE+Fywx/571UKEbu/4goureipv5JVRf58FuCHcVoUls0LDwTphnJViS5WLVlubZDu5gRaaDy9lmhet+cLzPy6fOMb/67Ye+oWICdtJYF+0Rhlw2KMKe6Ed8g5N+N1LVsGvg8tneQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NvlNM94t; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NvlNM94t"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57a2f27090aso6298164a12.0
        for <audit@vger.kernel.org>; Mon, 03 Jun 2024 15:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717453447; x=1718058247; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vUfCTj7RhneZiyZGwU4My8ep0xDaKOVngko5RyaH/ts=;
        b=NvlNM94t6sll7sF2XotPG849RkvwqA2mzJ7yLghmdoWCe/+h99vmOGCGjvSseh3s6r
         S/GfB/Qh0OaiI3bRW58c5ghzkxxojQrnJFc064N7uvD/XG7B0PItbqmuoTwHykQXxJCr
         +nEcQxl8fJ8V30NsnGDoJNRo9gdlJTmDzbEkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717453447; x=1718058247;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vUfCTj7RhneZiyZGwU4My8ep0xDaKOVngko5RyaH/ts=;
        b=BfhOaXR+In+aPJIEfFGIzcOBD6k/qim0Cdf5/yhAOQq0zIAOVLPiN2Pp/ACIxXTxMl
         TRoeWdAlaCrwbZUOvjuaD0BJMAHiLcoRqoCknr237BWQzatNKONdFyOeudZK5XHlJaMI
         oHPL6GUI3IY3XzObBbp8XKCff2VMmGTVSOHjr4cKyRosP/xc2oiPgS6ztbODn64DE2OU
         6UunhsTUDNfP/6KzZXxXApbG/MwpGNz3v8TjcvKtj4Qqxc4Qoz6lzrG1q4uP7oD0d8nL
         zoRxMOpWYhmCDw/bQAIbePCfI7SJkyuL5m9EAI3d/cnafo2ELQzfSywJzw/b+ZGtFWuH
         ioyw==
X-Forwarded-Encrypted: i=1; AJvYcCVlcDo3Rseyab6dNAdah9nVXtb3IZbxMnPcOAZVBXaaOXzwwtWmIlYOl/jFtf4HvgRHlOv5l+LG9JoDJf3fcjsMmrIclXU=
X-Gm-Message-State: AOJu0YxIK0ivaExgEdWAKyjJctj5JB0X9M+PEydlwYTQWGdU5ljwJUZz
	fIwor0i504NyWu4suOnBmseh0ohVBGiI5a4e5yCKUs9G0JGNsYEkxri+31TcwD8uuQL5cQyYRNi
	QP+29VQ==
X-Google-Smtp-Source: AGHT+IHrxN46NTRas6diLSRrdSTeM5+sj9S+Pp0uOmioD/eCM096VAb1uAhvzdOercTB2Hqmo38vAQ==
X-Received: by 2002:a50:aadc:0:b0:578:5f53:f017 with SMTP id 4fb4d7f45d1cf-57a7a6bb3ddmr773337a12.6.1717453446893;
        Mon, 03 Jun 2024 15:24:06 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a5dc1e2d6sm3088138a12.59.2024.06.03.15.24.05
        for <audit@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 15:24:05 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a68fc86acfaso256684266b.1
        for <audit@vger.kernel.org>; Mon, 03 Jun 2024 15:24:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWI4pgLryuORrY82G2AJuZ1EbhG/hTlQDnpGYKItLFkhP9egi4/N9Z8eq3uQ2ze/xI7yU+b79Fjb/u27nFP6H5SU9RpfH4=
X-Received: by 2002:a17:906:d217:b0:a62:49ae:cd7b with SMTP id
 a640c23a62f3a-a69543e118emr67505166b.24.1717453445163; Mon, 03 Jun 2024
 15:24:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602023754.25443-1-laoar.shao@gmail.com> <20240602023754.25443-3-laoar.shao@gmail.com>
 <20240603172008.19ba98ff@gandalf.local.home> <CAHk-=whPUBbug2PACOzYXFbaHhA6igWgmBzpr5tOQYzMZinRnA@mail.gmail.com>
 <20240603181943.09a539aa@gandalf.local.home>
In-Reply-To: <20240603181943.09a539aa@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Jun 2024 15:23:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgDWUpz2LG5KEztbg-S87N9GjPf5Tv2CVFbxKJJ0uwfSQ@mail.gmail.com>
Message-ID: <CAHk-=wgDWUpz2LG5KEztbg-S87N9GjPf5Tv2CVFbxKJJ0uwfSQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] tracing: Replace memcpy() with __get_task_comm()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Jun 2024 at 15:18, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> The logic behind __string() and __assign_str() will always add a NUL
> character.

Ok. But then you still end up with the issue that now the profiles are
different, and you have a 8-byte pointer to dynamically allocated
memory instead of just the simpler comm[TASK_COMM_LEN].

Is that actually a good idea for tracing?

We're trying to fix the core code to be cleaner for places that may
actually *care* (like 'ps').

Would we really want to touch this part of tracing?

            Linus
